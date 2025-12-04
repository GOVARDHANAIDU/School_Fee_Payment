/* -----------------------------------------
   STUDENT PROFILE MANAGEMENT JS (FINAL)
   Compatible with your current backend ONLY
------------------------------------------*/

let studentData = [];

/* -----------------------------------------
       Generate Initials for Avatar
------------------------------------------*/
function generateInitials(name) {
    if (!name) return "NA";
    const words = name.trim().split(/\s+/);
    if (words.length === 1) return words[0][0].toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
}

/* -----------------------------------------
          ON PAGE LOAD
------------------------------------------*/
$(document).ready(function () {
    console.log("Student Profile Loaded");

    const role = (window.userRole || "guest").toLowerCase();
    const admissionNo = window.admissionNo || null;

    // Student logged in → Only show own profile
    if (role === "student" && admissionNo) {
        console.log("🎓 Student Mode");
        $("#studentSearchWrapper").hide();
        $("#studentDropdown").prop("disabled", true);
        $("#studentDropdown").next(".select2-container").hide();

        hideEditControls();
        fetchStudentFromSession();
        return;
    }

    // Admin/Staff Mode → Can search
    $("#studentDropdown").select2({
        placeholder: "Search by name or admission no...",
        allowClear: true,
        width: "100%",
        dropdownParent: $("#studentDropdown").parent()
    });

    loadStudents();

    $("#studentDropdown").on("select2:select", function () {
        fetchStudent();
    });

    /* ------ EDIT BUTTON ------ */
    $("#editBtn").click(function () {
        if (role === "student") {
            alert("Students cannot edit their profile.");
            return;
        }

        $("input:not([type='hidden']), textarea")
            .prop("readonly", false)
            .removeClass("bg-light")
            .addClass("bg-white");

        $("#updateBtn, #resetBtn").removeClass("d-none");
        $(this).addClass("d-none");
    });

    /* ------ UPDATE BUTTON ------ */
    $("#updateBtn").click(function (e) {
        e.preventDefault();
        if (role === "student") {
            alert("Students cannot edit.");
            return;
        }

        const formData = {
            studentId: $("#studentId").val(),
            adminNo: $("#adminNo").val(),
            studentName: $("#studentName").val(),
            email: $("#email").val(),
            gender: $("#gender").val(),
            dob: $("#dob").val(),
            age: $("#age").val(),
            aadharNumber: $("#aadharNumber").val(),
            address: $("#address").val(),
            pincode: $("#pincode").val(),
            fatherName: $("#fatherName").val(),
            fatherNumber: $("#fatherNumber").val(),
            motherName: $("#motherName").val(),
            motherNumber: $("#motherNumber").val(),
            guardianName: $("#guardianName").val(),
            guardianNumber: $("#guardianNumber").val(),
            amount: $("#amount").val(),
            paidFee: $("#paidFee").val()
        };

        $.ajax({
            url: "UpdateStudentProfile",
            method: "POST",
            data: formData,
            success: function () {
                showToast("Profile updated successfully!");
                resetForm();
                fetchStudent();
            },
            error: function () {
                showToast("Update failed!", true);
            }
        });
    });

    /* ------ RESET BUTTON ------ */
    $("#resetBtn").click(function () {
        if (role === "student") {
            alert("Students cannot reset.");
            return;
        }
        resetForm();
        fetchStudent();
    });
});

/* -----------------------------------------
            LOAD STUDENT LIST
------------------------------------------*/
function loadStudents() {
    if (window.userRole === "student") return;

    $.ajax({
        url: "SearchServlet",
        method: "GET",
        dataType: "json",
        success: function (data) {
            studentData = data;
            $("#studentDropdown").empty().append(new Option("Select Student", ""));

            data.forEach(function (s) {
                const label = `${s.name} - ${s.admissionnumber}`;
                $("#studentDropdown").append(new Option(label, s.student_id));
            });
        },
        error: function () {
            showToast("Error loading students", true);
        }
    });
}

/* -----------------------------------------
          FETCH PROFILE (ADMIN)
------------------------------------------*/
function fetchStudent() {
    const id = $("#studentDropdown").val();
    if (!id) return showToast("Select a student", true);

    $("#profileLoading").removeClass("d-none");
    $("#profileContainer").hide();

    $.ajax({
        url: "GetStudentProfile",
        method: "POST",
        data: { studentId: id },
        dataType: "json",
        success: function (data) {
            console.log(" DEBUG: FetchStudent - Full data from backend:", data); // Debug: Log entire response
            if (data.error) return showToast(data.error, true);

            populateProfile(data);
            ensureReadonly();

            $("#profileLoading").addClass("d-none");
            $("#profileContainer").fadeIn();
        },
        error: function (xhr, status, error) {
            console.error(" DEBUG: FetchStudent Error:", error); // Debug: Log AJAX error
            showToast("Error fetching profile: " + error, true);
        }
    });
}

/* -----------------------------------------
   FETCH PROFILE FOR STUDENT (SESSION)
------------------------------------------*/
function fetchStudentFromSession() {
    $("#profileLoading").removeClass("d-none");
    $("#profileContainer").hide();

    $.ajax({
        url: "GetStudentProfile",
        method: "POST",
        data: {},
        dataType: "json",
        success: function (data) {
            console.log("DEBUG: FetchStudentFromSession - Full data from backend:", data); // Debug: Log entire response
            if (data.error) return showToast(data.error, true);

            populateProfile(data);
            ensureReadonly();
            hideEditControls();

            $("#profileLoading").addClass("d-none");
            $("#profileContainer").fadeIn();
        },
        error: function (xhr, status, error) {
            console.error("🔍 DEBUG: FetchStudentFromSession Error:", error); // Debug: Log AJAX error
            showToast("Error fetching profile: " + error, true);
        }
    });
}

/* -----------------------------------------
            POPULATE UI FIELDS
------------------------------------------*/
function populateProfile(data) {
    console.log("🔍 DEBUG: populateProfile - Full data received:", data); // Debug: Log entire data object

    // BASIC INFO
    $("#studentId").val(data.student_id || "");
    $("#adminNo").val(data.admin_no || "");
    $("#adminNoDisplay").text(data.admin_no || "ADM No.");

    const name = data.student_name || data.student_name || "";
    console.log("🔍 DEBUG: Student Name from backend:", name); // Debug: Log student name
    $("#studentName").val(name);
    $("#studentNameHeader").text(name || "Student Name");

    $("#email").val(data.email || "");
    $("#gender").val(data.gender || "");
    $("#dob").val(data.dob || "");
    $("#age").val(data.age || "");
    $("#aadharNumber").val(data.aadhar_number || "");
    $("#address").val(data.address || "");
    $("#pincode").val(data.pincode || "");

    // PARENTS
    $("#fatherName").val(data.father_name || "");
    $("#fatherNumber").val(data.father_number || "");
    $("#motherName").val(data.mother_name || "");
    $("#motherNumber").val(data.mother_number || "");
    $("#guardianName").val(data.guardian_name || "");
    $("#guardianNumber").val(data.guardian_number || "");

    // PAYMENT
    const totalFee = parseFloat(data.total_fee || data.total_fee || 0) || 0;
    const paidFee = parseFloat(data.paid_fee || data.paid_fee || 0) || 0;
    console.log("🔍 DEBUG: Total Fee from backend:", totalFee, "(raw:", data.total_fee || data.total_fee, ")"); // Debug: Log total fee
    console.log("🔍 DEBUG: Paid Fee from backend:", paidFee, "(raw:", data.paid_fee || data.paid_fee, ")"); // Debug: Log paid fee

    $("#totalFee").val(totalFee);
    $("#paidFee").val(paidFee);

    const balance = (totalFee - paidFee).toFixed(2);
    console.log("🔍 DEBUG: Calculated Balance:", balance); // Debug: Log balance
    $("#balance").text("₹" + balance);

    // Other tabs remain empty because backend doesn’t send data

    // AVATAR
    if (data.photo && data.photo !== "") {
        console.log("🔍 DEBUG: Using photo from backend:", data.photo); // Debug: Log photo usage
        $("#avatarPreview").attr("src", data.photo);
    } else {
        const initials = generateInitials(name);
        console.log("🔍 DEBUG: Generating initials avatar:", initials); // Debug: Log initials
        $("#avatarPreview").attr("src", generateAvatarInitials(initials));
    }
}

/* -----------------------------------------
        ENSURE READONLY MODE
------------------------------------------*/
function ensureReadonly() {
    $("input:not([type='hidden']), textarea")
        .prop("readonly", true)
        .addClass("bg-light");
}

function hideEditControls() {
    $("#editBtn, #updateBtn, #resetBtn").hide();
}

/* -----------------------------------------
          RESET FORM
------------------------------------------*/
function resetForm() {
    $("input:not([type='hidden']), textarea")
        .prop("readonly", true)
        .removeClass("bg-white")
        .addClass("bg-light");

    $("#editBtn").removeClass("d-none");
    $("#updateBtn, #resetBtn").addClass("d-none");
}

/* -----------------------------------------
               CAMERA
------------------------------------------*/
function startCamera() {
    const video = $("#video")[0];
    navigator.mediaDevices.getUserMedia({ video: true })
        .then(stream => {
            video.srcObject = stream;
            $("#cameraContainer").removeClass("d-none");
        })
        .catch(() => $("#cameraError").removeClass("d-none"));
}

function capturePhoto() {
    const video = $("#video")[0];
    const canvas = $("#canvas")[0];

    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;

    canvas.getContext("2d").drawImage(video, 0, 0);

    const imgData = canvas.toDataURL("image/png");
    $("#avatarPreview").attr("src", imgData);

    $("#cameraContainer").addClass("d-none");

    video.srcObject.getTracks().forEach(t => t.stop());
}

/* -----------------------------------------
           AVATAR UPLOAD / PREVIEW
------------------------------------------*/
function previewAvatar(event) {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = e => $("#avatarPreview").attr("src", e.target.result);
    reader.readAsDataURL(file);
}

/* -----------------------------------------
             UPLOAD PHOTO
------------------------------------------*/
$(document).on("click", "#modalUploadBtn", function () {

    const file = $("#fileInput")[0].files[0];
    const studentId = $("#studentId").val();

    if (!studentId) return showToast("Select a student first", true);
    if (!file) return showToast("Please choose a photo", true);

    const fd = new FormData();
    fd.append("studentId", studentId);
    fd.append("photo", file);

    $.ajax({
        url: "UploadPhotoServlet",
        type: "POST",
        data: fd,
        processData: false,
        contentType: false,
        success: function (msg) {
            showToast(msg);
            fetchStudent();
        },
        error: function (xhr) {
            showToast(xhr.responseText, true);
        }
    });
});

/* -----------------------------------------
       GENERATE CANVAS AVATAR (Initials)
------------------------------------------*/
function generateAvatarInitials(initials) {
    const canvas = document.createElement("canvas");
    canvas.width = 300;
    canvas.height = 300;
    const ctx = canvas.getContext("2d");

    ctx.fillStyle = "#007bff";
    ctx.beginPath();
    ctx.arc(150, 150, 150, 0, Math.PI * 2);
    ctx.fill();

    ctx.fillStyle = "#fff";
    ctx.font = "140px Arial";
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    ctx.fillText(initials, 150, 160);

    return canvas.toDataURL("image/png");
}

/* -----------------------------------------
                 TOAST
------------------------------------------*/
function showToast(msg, isError) {
    $("#toastMessage").text(msg);
    const toast = $("#liveToast");

    toast.removeClass("text-bg-danger text-bg-success");
    toast.addClass(isError ? "text-bg-danger" : "text-bg-success");

    new bootstrap.Toast(toast[0]).show();
}