let studentData = [];

/* -----------------------------------------
   HELPER: BUILD CONTEXT-SAFE URL
------------------------------------------*/
function getAbsoluteUrl(path) {
    return `${window.contextPath || ''}/${path}`;
}

/* -----------------------------------------
   GENERATE INITIALS FOR AVATAR
------------------------------------------*/
function generateInitials(name) {
    if (!name) return "NA";
    const words = name.trim().split(/\s+/);
    if (words.length === 1) return words[0][0].toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
}

/* -----------------------------------------
   GENERATE CANVAS AVATAR
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
   PAGE LOAD
------------------------------------------*/
$(document).ready(function () {
    console.log("Student Profile Loaded");
    console.log("Context Path:", window.contextPath);
    console.log("User Role:", window.userRole);
    console.log("Admission No:", window.admissionNo);

    const role = (window.userRole || "guest").toLowerCase();
    const admissionNo = window.admissionNo || null;

    // Student Mode: Hide search, load own profile from session
    if (role === "student" && admissionNo) {
        console.log("🎓 Student Mode Activated");
        $("#studentSearchWrapper").hide();
        $("#studentDropdown").prop("disabled", true).next(".select2-container").hide();
        hideEditControls();
        fetchStudentFromSession();
        return;
    }

    // Admin/Staff Mode: Enable search
    $("#studentDropdown").select2({
        placeholder: "Search by name or admission no...",
        allowClear: true,
        width: "100%",
        dropdownParent: $("#studentDropdown").parent()
    });

    loadStudents();

    $("#studentDropdown").on("select2:select", fetchStudent);

    // Edit Button
    $("#editBtn").click(function () {
        if (role === "student") {
            showToast("Students cannot edit their profile.", true);
            return;
        }

        $("input:not([type='hidden']), textarea")
            .prop("readonly", false)
            .removeClass("bg-light")
            .addClass("bg-white");

        $("#updateBtn, #resetBtn").removeClass("d-none");
        $("#editBtn").addClass("d-none");
    });

    // Update Button - With Photo Upload Support
    $("#updateBtn").click(function (e) {
        e.preventDefault();
        if (role === "student") {
            showToast("Students cannot update profile.", true);
            return;
        }

        const studentId = $("#studentId").val();
        if (!studentId || !$("#studentName").val().trim()) {
            return showToast("Student ID and Name are required.", true);
        }

        const fileInput = $("#fileInput")[0];
        const hasFile = fileInput && fileInput.files && fileInput.files.length > 0;

        const formFields = {
            studentId: studentId,
            adminNo: $("#adminNo").val(),
            studentName: $("#studentName").val().trim(),
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
            totalFee: $("#totalFee").val(),
            paidFee: $("#paidFee").val()
        };

        function uploadPhotoThenProfile() {
            if (!hasFile) {
                updateProfileOnly(formFields);
                return;
            }

            const fd = new FormData();
            fd.append("studentId", studentId);
            fd.append("photo", fileInput.files[0]);

            $.ajax({
                url: getAbsoluteUrl("UploadPhotoServlet"),
                type: "POST",
                data: fd,
                processData: false,
                contentType: false,
                success: function () {
                    showToast("Photo uploaded successfully!", false);
                    fileInput.value = "";
                    updateProfileOnly(formFields);
                },
                error: function (xhr) {
                    console.error("Photo upload failed:", xhr.responseText);
                    showToast("Photo upload failed. Updating profile anyway...", true);
                    updateProfileOnly(formFields);
                }
            });
        }

        function updateProfileOnly(fields) {
            $.ajax({
                url: getAbsoluteUrl("UpdateStudentProfile"),
                method: "POST",
                data: fields,
                success: function () {
                    showToast("Profile updated successfully!", false);
                    resetForm();
                    fetchStudent(); // Reload current student
                },
                error: function (xhr) {
                    showToast("Update failed: " + (xhr.responseText || "Server error"), true);
                }
            });
        }

        uploadPhotoThenProfile();
    });

    // Reset Button
    $("#resetBtn").click(function () {
        if (role === "student") return;
        resetForm();
        fetchStudent();
    });
});

/* -----------------------------------------
   LOAD STUDENTS (ADMIN ONLY)
------------------------------------------*/
function loadStudents() {
    $.ajax({
        url: getAbsoluteUrl("SearchServlet"),
        method: "GET",
        dataType: "json",
        success: function (data) {
            studentData = data;
            $("#studentDropdown").empty().append('<option value="">Select Student</option>');
            data.forEach(s => {
                const label = `${s.name} - ${s.admissionnumber}`;
                $("#studentDropdown").append(new Option(label, s.admissionnumber));
            });
        },
        error: function () {
            showToast("Failed to load student list.", true);
        }
    });
}

/* -----------------------------------------
   FETCH PROFILE (ADMIN - BY ADMISSION NO)
------------------------------------------*/
function fetchStudent() {
    const id = $("#studentDropdown").val();
    if (!id) return showToast("Please select a student.", true);

    toggleLoading(true);
	console.log("Enter into fetchstudent");
    $.ajax({
        url: getAbsoluteUrl("GetStudentProfile"),
        method: "POST",
        data: { admissionNo: id },
        dataType: "json",
        success: function (data) {
            if (data.error || data.success === false) {
                showToast(data.error || "Student not found", true);
                return;
            }
            populateProfile(data);
            ensureReadonly();
        },
        error: function (xhr, status, error) {
            // More robust error handling
            let errorMessage = "Failed to fetch profile.";
            
            if (xhr.responseText) {
                // Check if it's an HTML page (likely login redirect)
                if (xhr.responseText.trim().startsWith("<!DOCTYPE") || 
                    xhr.responseText.includes("login") || 
                    xhr.responseText.includes("session")) {
                    errorMessage = "Access denied. Please log in again.";
                } 
                // Try to parse JSON error if it's not HTML
                else {
                    try {
                        const errorData = JSON.parse(xhr.responseText);
                        if (errorData.error) {
                            errorMessage = errorData.error;
                        }
                    } catch (e) {
                        // Not JSON, keep default message
                    }
                }
            } else if (xhr.status === 401 || xhr.status === 403) {
                errorMessage = "Access denied. Please log in again.";
            } else if (xhr.status === 404) {
                errorMessage = "Student profile not found.";
            } else if (xhr.status === 500) {
                errorMessage = "Server error. Please try again later.";
            }
            
            showToast(errorMessage, true);
        },
        complete: function () {
            toggleLoading(false);
        }
    });
}
/* -----------------------------------------
   FETCH PROFILE (STUDENT - FROM SESSION)
------------------------------------------*/
function fetchStudentFromSession() {
    toggleLoading(true);

    $.ajax({
        url: getAbsoluteUrl("GetStudentProfile"),
        method: "POST",
        data: {}, // Servlet uses session
        dataType: "json",
        success: function (data) {
            console.log("Session Profile Data:", data);
            if (data.error || data.success === false) {
                showToast(data.error || "Your profile could not be loaded.", true);
                return;
            }
            populateProfile(data);
            ensureReadonly();
            hideEditControls();
        },
        error: function (xhr, status, error) {
            console.error("Session fetch error:", xhr);
            
            let errorMessage = "Failed to load your profile.";
            let redirectToLogin = false;
            
            if (xhr.responseText) {
                // Check for HTML response (likely login page)
                const responseStr = xhr.responseText.toString();
                if (responseStr.trim().startsWith("<!DOCTYPE") || 
                    responseStr.includes("login") || 
                    responseStr.includes("session") ||
                    responseStr.includes("expired")) {
                    errorMessage = "Session expired. Redirecting to login...";
                    redirectToLogin = true;
                } 
                // Try to parse JSON error
                else {
                    try {
                        const errorData = JSON.parse(responseStr);
                        if (errorData.error) {
                            errorMessage = errorData.error;
                        }
                    } catch (e) {
                        console.log("Response is not JSON");
                    }
                }
            } 
            // Check HTTP status codes
            else if (xhr.status === 401 || xhr.status === 403) {
                errorMessage = "Unauthorized access. Please log in again.";
                redirectToLogin = true;
            } else if (xhr.status === 0) {
                errorMessage = "Network error. Please check your connection.";
            } else if (xhr.status === 500) {
                errorMessage = "Server error. Please try again later.";
            }
            
            showToast(errorMessage, true);
            
            if (redirectToLogin) {
                setTimeout(() => {
                    window.location.href = getAbsoluteUrl("AdminLogin.jsp");
                }, 2000);
            }
        },
        complete: function () {
            toggleLoading(false);
        }
    });
}

/* -----------------------------------------
   POPULATE PROFILE FIELDS
------------------------------------------*/
function populateProfile(data) {
    console.log("Populating UI with:", data);

    $("#studentId").val(data.student_id || "");
    $("#adminNo").val(data.admin_no || "");
    $("#adminNoDisplay").text(data.admin_no || "ADM No.");

    const name = data.student_name || "";
    $("#studentName").val(name);
    $("#studentNameHeader").text(name || "Student Name");

    $("#email").val(data.email || "");
    $("#gender").val(data.gender || "");
    $("#dob").val(data.dob || "");
    $("#age").val(data.age || "");
    $("#aadharNumber").val(data.aadhar_number || "");
    $("#address").val(data.address || "");
    $("#pincode").val(data.pincode || "");

    $("#fatherName").val(data.father_name || "");
    $("#fatherNumber").val(data.father_number || "");
    $("#motherName").val(data.mother_name || "");
    $("#motherNumber").val(data.mother_number || "");
    $("#guardianName").val(data.guardian_name || "");
    $("#guardianNumber").val(data.guardian_number || "");

    // Handle fees safely
    let totalFee = parseFloat(data.total_fee) || 0;
    let paidFee = parseFloat(data.paid_fee) || 0;
    if (data.total_fee === "NA") totalFee = 0;
    if (data.paid_fee === "NA") paidFee = 0;

    $("#totalFee").val(totalFee.toFixed(2));
    $("#paidFee").val(paidFee.toFixed(2));
    $("#balance").text("₹" + (totalFee - paidFee).toFixed(2));

    if (data.class && $("#classField").length) {
        $("#classField").val(data.class);
    }

    // Avatar
    if (data.photo && data.photo !== "NA" && data.photo !== "") {
        $("#avatarPreview").attr("src", data.photo);
    } else {
        const initials = generateInitials(name);
        $("#avatarPreview").attr("src", generateAvatarInitials(initials));
    }
}

/* -----------------------------------------
   UI HELPERS
------------------------------------------*/
function ensureReadonly() {
    $("input:not([type='hidden']), textarea")
        .prop("readonly", true)
        .addClass("bg-light")
        .removeClass("bg-white");
}

function hideEditControls() {
    $("#editBtn, #updateBtn, #resetBtn").hide();
}

function resetForm() {
    ensureReadonly();
    $("#editBtn").removeClass("d-none");
    $("#updateBtn, #resetBtn").addClass("d-none");
    $("#fileInput").val("");
}

function toggleLoading(show) {
    if (show) {
        $("#profileLoading").removeClass("d-none");
        $("#profileContainer").hide();
    } else {
        $("#profileLoading").addClass("d-none");
        $("#profileContainer").fadeIn();
    }
}

/* -----------------------------------------
   TOAST NOTIFICATION (UNIFIED)
------------------------------------------*/
function showToast(msg, isError = false) {
    const toastEl = $("#liveToast")[0];
    if (!toastEl) {
        alert(msg); // Fallback
        return;
    }
    $("#toastMessage").text(msg);
    $("#liveToast")
        .removeClass("text-bg-success text-bg-danger")
        .addClass(isError ? "text-bg-danger" : "text-bg-success");

    new bootstrap.Toast(toastEl).show();
}

// Global zoom level
let currentZoom = 1;

function openPhotoViewer() {
    const avatarSrc = document.getElementById('avatarPreview').src;
    const fullPhoto = document.getElementById('fullPhoto');
    
    if (avatarSrc && avatarSrc !== location.href) {
        fullPhoto.src = avatarSrc;
        currentZoom = 1;
        fullPhoto.style.transform = 'scale(1)';
        const modal = new bootstrap.Modal(document.getElementById('photoViewerModal'));
        modal.show();
    } else {
        alert("No photo available to view.");
    }
}

function zoomPhoto(factor) {
    currentZoom *= factor;
    // Limit zoom between 0.5x and 5x
    currentZoom = Math.min(Math.max(currentZoom, 0.5), 5);
    document.getElementById('fullPhoto').style.transform = `scale(${currentZoom})`;
}

function resetZoom() {
    currentZoom = 1;
    document.getElementById('fullPhoto').style.transform = 'scale(1)';
}

// Optional: Keyboard shortcuts (Esc already closes, add + / -)
document.getElementById('photoViewerModal').addEventListener('shown.bs.modal', () => {
    document.addEventListener('keydown', handleZoomKeys);
});

document.getElementById('photoViewerModal').addEventListener('hidden.bs.modal', () => {
    document.removeEventListener('keydown', handleZoomKeys);
});

function handleZoomKeys(e) {
    if (e.key === '+' || e.key === '=') {
        e.preventDefault();
        zoomPhoto(1.2);
    } else if (e.key === '-') {
        e.preventDefault();
        zoomPhoto(0.8);
    } else if (e.key === '0') {
        e.preventDefault();
        resetZoom();
    }
}