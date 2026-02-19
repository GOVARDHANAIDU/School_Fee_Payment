// js/billing.js
let studentData = [];

$(document).ready(function () {
    const $payingFee = $('#payingfee');
    const $proceedBtn = $('.preview');
    const role = window.userRole || "guest";
    const admissionNo = window.admissionNo || null;

    console.log("🎯 Role Detected:", role, "| Admission No:", admissionNo);

    // Clear any cached data
    studentData = [];

    if (role.toLowerCase() === "student" && admissionNo) {
        console.log("👨‍🎓 Student Login: Fetching only personal details...");

        // Hide dropdown for student
        $('label[for="studentDropdown"]').hide();
        $('#studentDropdown').hide();

        // Change title
        $('h2').text('Your Fee Payment Details');

        // Fetch only this student's details - force fresh data
        fetchStudentByAdmissionNo(admissionNo, true);

    } else {
        console.log("🧑‍💼 Admin/Teacher Login: Loading all students...");

        // Initialize Select2
        $('#studentDropdown').select2({
            placeholder: 'Search or select a student',
            allowClear: true,
            width: '100%'
        });

        // Load student list - force fresh data
        loadAllStudents(true);

        // On selection
        $('#studentDropdown').on('select2:select', function (e) {
            const selectedName = e.params.data.text;
            const selectedId = e.params.data.id;
            
            // Force fresh fetch of student data
            fetchStudentDetails(selectedId || selectedName);
        });
    }

    // Paying fee logic
    $payingFee.on('input', toggleProceedButton);
    toggleProceedButton();

    $('#proceedBtn').on('click', handleProceed);
    
    // Add refresh button event if exists
    $('#refreshBtn').on('click', function() {
        location.reload(true); // Force reload from server
    });
});

function loadAllStudents(forceRefresh = false) {
    const cacheKey = 'studentListCache';
    const cacheTime = localStorage.getItem(cacheKey + '_time');
    const now = new Date().getTime();
    
    // Use cache only if not forcing refresh and cache is less than 5 minutes old
    if (!forceRefresh && cacheTime && (now - cacheTime < 300000)) {
        const cachedData = localStorage.getItem(cacheKey);
        if (cachedData) {
            try {
                studentData = JSON.parse(cachedData);
                populateDropdown(studentData);
                return;
            } catch (e) {
                console.warn("Cache parse error:", e);
            }
        }
    }
    
    $.ajax({
        url: 'SearchServlet',
        method: 'GET',
        dataType: 'json',
        cache: false, // Prevent browser caching
        headers: {
            'Cache-Control': 'no-cache, no-store, must-revalidate',
            'Pragma': 'no-cache',
            'Expires': '0'
        },
        success: function (data) {
            studentData = data || [];
            
            // Cache the data
            localStorage.setItem(cacheKey, JSON.stringify(studentData));
            localStorage.setItem(cacheKey + '_time', now.toString());
            
            populateDropdown(studentData);
            console.log("📥 Loaded fresh students:", data.length);
        },
        error: function (xhr, status, error) {
            console.error("Error loading students:", error);
            alert("⚠️ Error loading students. Please try refreshing the page.");
        }
    });
}

function populateDropdown(data) {
    $('#studentDropdown').empty().append(new Option("Select Student", ""));
    
    data.forEach(s => {
        // Use admission number as value for more precise lookup
        $('#studentDropdown').append(new Option(s.name, s.admissionnumber));
    });
}

function fetchStudentDetails(studentIdentifier) {
    // Clear previous student data
    clearStudentFields();
    
    console.log("🔍 Fetching student details for:", studentIdentifier);
    
    $.ajax({
        url: 'GetStudentProfile',
        method: 'POST',
        data: { 
            admissionNo: studentIdentifier,
            forceRefresh: 'true' // Signal server to bypass cache
        },
        dataType: 'json',
        cache: false,
        headers: {
            'Cache-Control': 'no-cache, no-store, must-revalidate'
        },
        success: function (data) {
            if (data.error) {
                alert(data.error);
                return;
            }

            console.log("✅ Fresh Student Data Loaded:", data);
            
            // DEBUG: Log all keys in the response
            console.log("📋 All keys in response:", Object.keys(data));
            console.log("🔤 Class field check:");
            console.log("- data.class1:", data.class1);
            console.log("- data.class:", data.class);
            console.log("- data.student_class:", data.student_class);
            console.log("- data.className:", data.className);
            
            // Calculate remaining fee properly
            const totalFee = parseFloat(data.total_fee) || 0;
            const paidFee = parseFloat(data.paid_fee) || 0;
            const remainingFee = totalFee - paidFee;
            
            // Ensure remaining fee is not negative
            const validRemainingFee = Math.max(0, remainingFee);
            
            const mapped = {
                name: data.student_name,
                email: data.email,
                phone: data.father_number || data.guardian_number || "",
                amount: totalFee,
                paidfee: paidFee,
                payingfee: validRemainingFee,
                admissionnumber: data.admin_no,
                class1: data.class1 || data.class || data.student_class || data.className || "N/A" // Try multiple keys
            };

            console.log("📝 Mapped student data:", mapped);
            console.log("🎓 Class value being set:", mapped.class1);
            
            fillStudentFields(mapped);
            
            // Update the dropdown display
            $('#studentDropdown').val(data.admin_no).trigger('change.select2');
        },
        error: function (xhr, status, error) {
            console.error("Error fetching student details:", error);
            alert("⚠️ Error fetching student details. Please try again.");
        }
    });
}

function fetchStudentByAdmissionNo(admissionNo, forceRefresh = false) {
    // Clear previous data
    clearStudentFields();
    
    console.log("🔍 Fetching student by admission no:", admissionNo);
    
    $.ajax({
        url: 'GetStudentProfile',
        method: 'POST',
        data: { 
            admissionNo: admissionNo,
            forceRefresh: forceRefresh ? 'true' : 'false'
        },
        dataType: 'json',
        cache: false,
        success: function (data) {
            if (data.error) {
                alert(data.error);
                return;
            }

            console.log("✅ Student Profile Loaded:", data);
            
            // DEBUG: Log all keys in the response
            console.log("📋 All keys in response:", Object.keys(data));
            console.log("🔤 Class field check:");
            console.log("- data.class1:", data.class1);
            console.log("- data.class:", data.class);
            console.log("- data.student_class:", data.student_class);
            console.log("- data.className:", data.className);

            // Insert student name field if it doesn't exist
            if (!$('#studentNameField').length) {
                const $selectContainer = $('#studentDropdown').parent();
                $selectContainer.before(`
                    <label for="studentNameField">Student Name:</label>
                    <input type="text" id="studentNameField" value="${data.student_name}"
                           readonly class="form-control mb-2"
                           style="background-color:#f1f5f9;font-weight:500;" />
                `);
            } else {
                // Update existing field
                $('#studentNameField').val(data.student_name);
            }

            // Calculate remaining fee properly
            const totalFee = parseFloat(data.total_fee) || 0;
            const paidFee = parseFloat(data.paid_fee) || 0;
            const remainingFee = totalFee - paidFee;
            
            // Ensure remaining fee is not negative
            const validRemainingFee = Math.max(0, remainingFee);
            
            const mapped = {
                name: data.student_name,
                email: data.email,
                phone: data.father_number || data.guardian_number || "",
                amount: totalFee,
                paidfee: paidFee,
                payingfee: validRemainingFee,
                admissionnumber: data.admin_no,
                class1: data.class1 || data.class || data.student_class || data.className || "N/A" // Try multiple keys
            };

            console.log("📝 Mapped student data:", mapped);
            console.log("🎓 Class value being set:", mapped.class1);
            
            fillStudentFields(mapped);
        },
        error: function (xhr, status, error) {
            console.error("Error fetching student details:", error);
            alert("⚠️ Error fetching your details.");
        }
    });
}

function clearStudentFields() {
    console.log("🧹 Clearing student fields");
    $('#email').val('');
    $('#phone').val('');
    $('#totalFee').val('');
    $('#paidfee').val('');
    $('#payingfee').val('');
    $('#admissionnumber').val('');
    $('#class1').val('');
    console.log("✅ Fields cleared");
}

function fillStudentFields(s) {
    console.log("📝 Filling student fields with:", s);
    
    $('#email').val(s.email || '');
    $('#phone').val(s.phone || '');
    
    // Ensure total fee is properly set
    let totalAmount = parseFloat(s.amount) || 0;
    $('#totalFee').val(totalAmount.toFixed(2));
    console.log("💰 Total Fee Set:", totalAmount);

    // Set paid fee
    const paidAmount = parseFloat(s.paidfee) || 0;
    $('#paidfee').val(paidAmount.toFixed(2));

    // Calculate and set paying fee (remaining)
    let remaining = parseFloat(s.payingfee) || 0;
    
    // Double-check calculation
    if (remaining <= 0 && totalAmount > 0) {
        remaining = totalAmount - paidAmount;
    }
    
    // Ensure remaining is not negative
    remaining = Math.max(0, remaining);
    
    $('#payingfee').val(remaining.toFixed(2));
    
    // Update admission number and class
    $('#admissionnumber').val(s.admissionnumber || '');
    
    // DEBUG: Set class field
    console.log("🎓 Setting class field with value:", s.class1);
    $('#class1').val(s.class1 || '');
    console.log("✅ Class field value after setting:", $('#class1').val());

    // Log for debugging
    console.log("📊 Student Data Summary:", {
        total: totalAmount,
        paid: paidAmount,
        remaining: remaining,
        calculatedRemaining: totalAmount - paidAmount,
        class: s.class1,
        classFieldValue: $('#class1').val()
    });

    toggleProceedButton();
}

function toggleProceedButton() {
    const value = parseFloat($('#payingfee').val()) || 0;
    const totalFee = parseFloat($('#totalFee').val()) || 0;
    const paidFee = parseFloat($('#paidfee').val()) || 0;
    const classValue = $('#class1').val();
    
    console.log("🎓 Current class field value:", classValue);
    
    // Enable button only if:
    // 1. Paying fee is greater than 0
    // 2. Total fee is valid
    // 3. Student is selected
    const isStudentSelected = $('#admissionnumber').val().trim() !== '';
    const isValidTotalFee = totalFee > 0;
    const isValidPayingFee = value > 0 && value <= (totalFee - paidFee);
    
    $('.preview').prop('disabled', !(value > 0 && isValidTotalFee && isStudentSelected));
    
    // Show validation message if needed
    if (value > (totalFee - paidFee)) {
        showMessage('Paying amount cannot exceed remaining balance', 'warning');
    }
}

function handleProceed() {
    // Get current values
    const totalFee = parseFloat($('#totalFee').val()) || 0;
    const paidFee = parseFloat($('#paidfee').val()) || 0;
    const payingFee = parseFloat($('#payingfee').val()) || 0;
    const classValue = $('#class1').val();
    
    console.log("🚀 Proceeding with data:", {
        totalFee,
        paidFee,
        payingFee,
        class: classValue,
        classField: $('#class1').val()
    });
    
    // Validate
    if (isNaN(totalFee) || totalFee <= 0) {
        alert("❌ Total Fee is missing or invalid. Please select a valid student.");
        return;
    }
    
    if (payingFee <= 0) {
        alert("❌ Paying amount must be greater than 0.");
        return;
    }
    
    if (payingFee > (totalFee - paidFee)) {
        alert("❌ Paying amount cannot exceed remaining balance.");
        return;
    }

    const studentName = $('#studentNameField').length
        ? $('#studentNameField').val()
        : $('#studentDropdown option:selected').text();

    const formData = new URLSearchParams();
    formData.append("studentName", studentName || '');
    formData.append("email", $('#email').val() || '');
    formData.append("amount", totalFee.toString());
    formData.append("paidfee", paidFee.toString());
    formData.append("class1", $('#class1').val() || '');
    formData.append("admissionnumber", $('#admissionnumber').val() || '');
    formData.append("phone", $('#phone').val() || '');
    formData.append("payingfee", payingFee.toString());
    formData.append("paymentMode", $('#paymentMode').val() || 'Cash');
    formData.append("timestamp", new Date().getTime().toString()); // Prevent caching

    console.log("📤 Submitting formData:", Object.fromEntries(formData));

    // Show loading
    $('#proceedBtn').prop('disabled', true).html('<span class="spinner-border spinner-border-sm"></span> Processing...');

    fetch("previewthebill", {
        method: "POST",
        headers: { 
            "Content-Type": "application/x-www-form-urlencoded",
            "Cache-Control": "no-cache"
        },
        body: formData.toString()
    })
    .then(res => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        return res.text();
    })
    .then(html => {
        // Clear cache after successful payment
        localStorage.removeItem('studentListCache');
        localStorage.removeItem('studentListCache_time');
        
        if (html.includes("<!--payment-page-->")) {
            window.location.href = "PreviewPage.jsp?timestamp=" + new Date().getTime();
        } else {
            document.open(); 
            document.write(html); 
            document.close();
        }
    })
    .catch(err => {
        console.error("❌ Error at Billing page:", err);
        alert("⚠️ Submission failed. Please try again.");
    })
    .finally(() => {
        // Reset button
        $('#proceedBtn').prop('disabled', false).html('Proceed to Preview');
    });
}

function showMessage(message, type = 'info') {
    // Remove existing messages
    $('.alert-message').remove();
    
    const alertClass = type === 'warning' ? 'alert-warning' : 'alert-info';
    const $alert = $(`
        <div class="alert ${alertClass} alert-message alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `);
    
    // Insert after the form
    $('.preview').before($alert);
    
    // Auto-dismiss after 5 seconds
    setTimeout(() => {
        $alert.alert('close');
    }, 5000);
}

// Add refresh capability
$(document).on('click', '.refresh-student', function() {
    const admissionNo = $('#admissionnumber').val();
    if (admissionNo) {
        fetchStudentByAdmissionNo(admissionNo, true);
    }
});