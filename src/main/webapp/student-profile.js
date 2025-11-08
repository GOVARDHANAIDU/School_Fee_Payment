let studentData = [];

function generateInitials(name) {
    if (!name) return 'AV';
    const words = name.trim().split(/\s+/);
    if (words.length === 0) return 'AV';
    let initials = words[0].charAt(0).toUpperCase();
    if (words.length > 1) {
        initials += words[words.length - 1].charAt(0).toUpperCase();
    }
    return initials;
}

$(document).ready(function () {
    console.log("✅ Initializing profile page...");
    $('#studentDropdown').select2({
        placeholder: 'Search by name or admission no...',
        allowClear: true,
        width: '100%',
        dropdownParent: $('#studentDropdown').parent()
    });

    // Load students
    $.ajax({
        url: 'SearchServlet',
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            console.log("✅ Students loaded:", data.length);
            if (!Array.isArray(data) || data.length === 0) return;
            studentData = data;
            $('#studentDropdown').empty().append(new Option("Select Student", ""));
            data.forEach(function (student) {
                const text = `${student.name} - ${student.admissionnumber}`;
                $('#studentDropdown').append(new Option(text, student.student_id));
            });
        },
        error: function () {
            alert("Error loading students");
        }
    });

    // Auto-fetch on select
    $('#studentDropdown').on('select2:select', function () {
        fetchStudent();
    });

    // Edit toggle
    $('#editBtn').click(function() {
        $('input:not([type="hidden"]), textarea').prop('readonly', false).removeClass('bg-light').addClass('bg-white');
        $('#updateBtn, #resetBtn').removeClass('d-none');
        $(this).addClass('d-none');
    });

    // Update
    $('#updateBtn').click(function(e) {
        e.preventDefault();
        const formData = {
            studentId: $('#studentId').val(),
            adminNo: $('#adminNo').val(),
            studentName: $('#studentName').val(),
            email: $('#email').val(),
            gender: $('#gender').val(),
            dob: $('#dob').val(),
            age: $('#age').val(),
            aadharNumber: $('#aadharNumber').val(),
            address: $('#address').val(),
            pincode: $('#pincode').val(),
            fatherName: $('#fatherName').val(),
            fatherNumber: $('#fatherNumber').val(),
            motherName: $('#motherName').val(),
            motherNumber: $('#motherNumber').val(),
            guardianName: $('#guardianName').val(),
            guardianNumber: $('#guardianNumber').val(),
            totalFee: $('#totalFee').val(),
            paidFee: $('#paidFee').val(),
            // Add new fields
            className: $('#className').val(),
            section: $('#section').val(),
            rollNo: $('#rollNo').val(),
            classTeacher: $('#classTeacher').val(),
            totalDays: $('#totalDays').val(),
            presentDays: $('#presentDays').val(),
            attendancePct: $('#attendancePct').val(),
            mathMarks: $('#mathMarks').val(),
            mathGrade: $('#mathGrade').val(),
            scienceMarks: $('#scienceMarks').val(),
            scienceGrade: $('#scienceGrade').val(),
            englishMarks: $('#englishMarks').val(),
            englishGrade: $('#englishGrade').val(),
            avgMarks: $('#avgMarks').val(),
            avgGrade: $('#avgGrade').val()
        };
        $.ajax({
            url: 'UpdateStudentProfile',
            method: 'POST',
            data: formData,
            success: function() {
                alert('Profile updated!');
                resetForm();
                fetchStudent(); // Refresh
            },
            error: function() {
                alert('Update failed!');
            }
        });
    });

    // Reset
    $('#resetBtn').click(function() {
        resetForm();
        fetchStudent();
    });

    function resetForm() {
        $('input:not([type="hidden"]), textarea').prop('readonly', true).removeClass('bg-white').addClass('bg-light');
        $('#editBtn').removeClass('d-none');
        $('#updateBtn, #resetBtn').addClass('d-none');
    }
});

function fetchStudent() {
    const selectedId = $('#studentDropdown').val();
    if (!selectedId) return alert('Select a student');

    // Show loading
    $('#profileLoading').removeClass('d-none');
    $('#profileContainer').hide();

    $.ajax({
        url: 'GetStudentProfile',
        method: 'POST',
        data: { studentId: selectedId },
        dataType: 'json',
        success: function(data) {
            console.log("✅ Profile fetched");
            if (data.error) return alert(data.error);

            // Populate fields
            $('#studentId').val(data.student_id || '');
            $('#adminNo').val(data.admin_no || '');
            $('#adminNoDisplay').text(data.admin_no || 'ADM No.');
            $('#studentName').val(data.student_name || '');
            $('#email').val(data.email || '');
            $('#gender').val(data.gender || '');
            $('#dob').val(data.dob || '');
            $('#age').val(data.age || '');
            $('#aadharNumber').val(data.aadhar_number || '');
            $('#address').val(data.address || '');
            $('#pincode').val(data.pincode || '');
            $('#fatherName').val(data.father_name || '');
            $('#fatherNumber').val(data.father_number || '');
            $('#motherName').val(data.mother_name || '');
            $('#motherNumber').val(data.mother_number || '');
            $('#guardianName').val(data.guardian_name || '');
            $('#guardianNumber').val(data.guardian_number || '');
            $('#totalFee').val(data.total_fee || 0);
            $('#paidFee').val(data.paid_fee || 0);

            // New fields (sample data; replace with actual from backend)
            $('#className').val(data.class_name || '10th Grade');
            $('#section').val(data.section || 'A');
            $('#rollNo').val(data.roll_no || '15');
            $('#classTeacher').val(data.class_teacher || 'John Doe');
            $('#academicYear').val(data.academic_year || '2025-2026');
            $('#totalDays').val(data.total_days || 180);
            $('#presentDays').val(data.present_days || 162);
            $('#attendancePct').val(data.attendance_pct || '90%');
            $('#mathMarks').val(data.math_marks || 85);
            $('#mathGrade').val(data.math_grade || 'A');
            $('#scienceMarks').val(data.science_marks || 92);
            $('#scienceGrade').val(data.science_grade || 'A+');
            $('#englishMarks').val(data.english_marks || 78);
            $('#englishGrade').val(data.english_grade || 'B');
            $('#avgMarks').val(data.avg_marks || 85);
            $('#avgGrade').val(data.avg_grade || 'A');

            // Balance
            const balance = (parseFloat(data.total_fee || 0) - parseFloat(data.paid_fee || 0)).toFixed(2);
            $('#balance').text('₹' + balance)
                .removeClass('balance-positive balance-negative text-success text-danger')
                .addClass(balance >= 0 ? 'balance-positive text-success' : 'balance-negative text-danger');

            // Header
            $('#studentNameHeader').text(data.student_name || 'Student Profile');

            // Avatar: Use photo if available, else initials
            if (data.photo) {
                $('#avatarPreview').attr('src', data.photo);
            } else {
                const initials = generateInitials(data.student_name);
                $('#avatarPreview').attr('src', `https://via.placeholder.com/100x100/007bff/ffffff?text=${initials}`);
            }

            $('#photo').attr('src', data.fullPhoto || '').toggle(!!data.fullPhoto);

            // Ensure readonly
            $('input:not([type="hidden"]), textarea').prop('readonly', true).addClass('bg-light');

            // Hide loading and show profile with animation
            $('#profileLoading').addClass('d-none');
            $('#profileContainer').fadeIn(500);
        },
        error: function() {
            $('#profileLoading').addClass('d-none');
            alert("Error fetching profile");
        }
    });
}

// Camera functions
function startCamera() {
    const video = $('#video')[0];
    navigator.mediaDevices.getUserMedia({ video: true }).then(stream => {
        video.srcObject = stream;
        $('#cameraContainer').removeClass('d-none');
    }).catch(() => $('#cameraError').removeClass('d-none'));
}

function capturePhoto() {
    const video = $('#video')[0];
    const canvas = $('#canvas')[0];
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    canvas.getContext('2d').drawImage(video, 0, 0);
    const imgData = canvas.toDataURL('image/png');
    $('#avatarPreview').attr('src', imgData);
    $('#cameraContainer').addClass('d-none');
    video.srcObject.getTracks().forEach(track => track.stop());
}

function previewAvatar(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            $('#avatarPreview').attr('src', e.target.result);
        };
        reader.readAsDataURL(file);
    }
    $('#avatarModal').modal('hide');
}