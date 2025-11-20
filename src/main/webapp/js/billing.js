let studentData = [];

$(document).ready(function () {
    const $payingFee = $('#payingfee');
    const $proceedBtn = $('.preview');
    const role = window.userRole || "guest";
    const admissionNo = window.admissionNo || null;

    console.log("🎯 Role Detected:", role, "| Admission No:", admissionNo);

    if (role.toLowerCase() === "student" && admissionNo) {
        console.log("👨‍🎓 Student Login: Fetching only personal details...");

        // Hide dropdown for student
        $('label[for="studentDropdown"]').hide();
        $('#studentDropdown').hide();

        // Change title
        $('h2').text('Your Fee Payment Details');

        // Fetch only this student's details
        fetchStudentByAdmissionNo(admissionNo);

    } else {

        console.log("🧑‍💼 Admin/Teacher Login: Loading all students...");

        // Initialize Select2
        $('#studentDropdown').select2({
            placeholder: 'Search or select a student',
            allowClear: true,
            width: '100%'
        });

        // Load student list
        loadAllStudents();

        // On selection
        $('#studentDropdown').on('select2:select', function (e) {
            const selectedName = e.params.data.text;
            const selectedStudent = studentData.find(s => s.name === selectedName);

            if (selectedStudent) {
                fillStudentFields({
                    name: selectedStudent.name,
                    email: selectedStudent.email,
                    phone: selectedStudent.phone,
                    amount: selectedStudent.total_fee,
                    paidfee: selectedStudent.paid_fee,
                    payingfee: selectedStudent.remaining_fee,
                    admissionnumber: selectedStudent.admissionnumber,
                    class1: selectedStudent.class1
                });
            }
        });
    }

    // Paying fee logic
    $payingFee.on('input', toggleProceedButton);
    toggleProceedButton();

    $('#proceedBtn').on('click', handleProceed);
});

function loadAllStudents() {
    $.ajax({
        url: 'SearchServlet',
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            studentData = data || [];

            $('#studentDropdown').empty().append(new Option("Select Student", ""));

            data.forEach(s => {
                $('#studentDropdown').append(new Option(s.name, s.name));
            });

            console.log("📥 Loaded students:", data.length);
        },
        error: function () {
            alert("⚠️ Error loading students.");
        }
    });
}

function fetchStudentByAdmissionNo(admissionNo) {
    $.ajax({
        url: 'GetStudentProfile',
        method: 'POST',
        data: { admissionNo: admissionNo },
        dataType: 'json',
        success: function (data) {
            if (data.error) {
                alert(data.error);
                return;
            }

            console.log("✅ Student Profile Loaded:", data.student_name);

            // Insert student name field
            const $selectContainer = $('#studentDropdown').parent();

            $selectContainer.before(`
                <label for="studentNameField">Student Name:</label>
                <input type="text" id="studentNameField" value="${data.student_name}"
                       readonly class="form-control mb-2"
                       style="background-color:#f1f5f9;font-weight:500;" />
            `);

            // Map backend fields
            const mapped = {
                name: data.student_name,
                email: data.email,
                phone: data.father_number || data.guardian_number || "",
                amount: data.total_fee,
                paidfee: data.paid_fee,
                payingfee: data.remaining_fee || (data.total_fee - data.paid_fee),
                admissionnumber: data.admin_no,
                class1: data.class1
            };

            fillStudentFields(mapped);
        },
        error: function () {
            alert("⚠️ Error fetching your details.");
        }
    });
}

function fillStudentFields(s) {
    $('#email').val(s.email);
    $('#phone').val(s.phone);
    $('#amount').val(s.amount);
    $('#paidfee').val(s.paidfee);

    // Auto calculate remaining fee
    const remaining = parseFloat(s.amount) - parseFloat(s.paidfee);
    $('#payingfee').val(remaining);

    $('#admissionnumber').val(s.admissionnumber);
    $('#class1').val(s.class1);

    toggleProceedButton();
}

function toggleProceedButton() {
    const value = parseFloat($('#payingfee').val());
    $('.preview').prop('disabled', !(value > 0));
}

function handleProceed() {

    const studentName = $('#studentNameField').length
        ? $('#studentNameField').val()
        : $('#studentDropdown').val();

    const formData = new URLSearchParams();
    formData.append("studentName", studentName);
    formData.append("email", $('#email').val());
    formData.append("amount", $('#total_fee').val());
    formData.append("paidfee", $('#paidfee').val());
    formData.append("class1", $('#class1').val());
    formData.append("admissionnumber", $('#admissionnumber').val());
    formData.append("phone", $('#phone').val());
    formData.append("payingfee", $('#payingfee').val());
    formData.append("paymentMode", $('#paymentMode').val());

    fetch("previewthebill", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: formData.toString()
    })
    .then(res => res.text())
    .then(html => {
        if (html.includes("<!--payment-page-->")) {
            window.location.href = "PreviewPage.jsp";
        } else {
            document.open(); document.write(html); document.close();
        }
    })
    .catch(err => console.error("❌ Error at Billing page:", err));
}



