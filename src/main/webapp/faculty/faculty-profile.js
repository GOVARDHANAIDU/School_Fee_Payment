/* -----------------------------------------
   FACULTY PROFILE MANAGEMENT JS (FINAL)
------------------------------------------*/

let facultyData = [];

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
    console.log("Faculty Profile Loaded");

    const role = (window.userRole || "guest").toLowerCase();
    const facultyID = window.facultyID || null;

    // Faculty logged in → Only show own profile
    if (role === "faculty" && facultyID) {
        console.log("🎓 Faculty Mode");
        $("#facultySearchWrapper").hide();
        $("#facultyDropdown").prop("disabled", true);
        $("#facultyDropdown").next(".select2-container").hide();

        hideEditControls();
        fetchFacultyFromSession();
        return;
    }

    // Admin Mode → Can search
    $("#facultyDropdown").select2({
        placeholder: "Search Faculty Name / Faculty ID",
        allowClear: true,
        width: "100%",
        dropdownParent: $("#facultyDropdown").parent()
    });

    loadFaculty();

    $("#facultyDropdown").on("select2:select", function () {
        fetchFaculty();
    });

    /* ------ EDIT BUTTON ------ */
    $("#editBtn").click(function () {
        if (role === "faculty") {
            alert("Faculty cannot edit their profile.");
            return;
        }

        $("input:not([type='hidden']), textarea").prop("readonly", false)
            .removeClass("bg-light")
            .addClass("bg-white");

        $("#updateBtn, #resetBtn").removeClass("d-none");
        $(this).addClass("d-none");
    });

    /* ------ UPDATE BUTTON (Implemented: Collect form data & send to servlet) ------ */
    $("#updateBtn").click(function () {


        // Collect form data
        const formData = new FormData();
        formData.append("facultyId", facultyId);
        formData.append("name", $("#name").val());
        formData.append("email", $("#email").val());
        formData.append("phone_number", $("#phone_number").val());
        formData.append("aadhar_number", $("#aadhar_number").val());
        formData.append("gender", $("#gender").val());
        formData.append("dob", $("#dob").val());
        formData.append("qualification", $("#qualification").val());
        formData.append("department", $("#department").val());
        formData.append("designation", $("#designation").val());
        formData.append("experience_years", $("#experience_years").val());
        formData.append("join_date", $("#join_date").val());
        formData.append("salary", $("#salary").val().replace(/[^0-9.]/g, ''));  // Strip ₹ & commas for DB
        formData.append("address", $("#address").val());
        formData.append("city", $("#city").val());
        formData.append("state", $("#state").val());
        formData.append("pincode", $("#pincode").val());
        formData.append("status", $("#status").val());

        // Photo upload (if changed)
        const photoInput = $("#fileInput")[0].files[0];
        if (photoInput) {
            formData.append("photo", photoInput);
        }

        // Auto-detect context path
        const contextPath = window.location.pathname.split('/')[1] || '';
        const updateUrl = '/' + contextPath + '/UpdateFacultyProfile';

        $.ajax({
            url: updateUrl,
            method: "POST",
            data: formData,
            processData: false,  // For FormData
            contentType: false,  // For FormData
            dataType: "text",
            success: function (msg) {
                showToast(msg, false);
                resetForm();  // Reset to readonly
                fetchFaculty();  // Reload updated profile
            },
            error: function (xhr, status, error) {
                console.error("Update error:", xhr.responseText);
                showToast("Update failed: " + error, true);
            }
        });
    });

    /* ------ RESET BUTTON ------ */
    $("#resetBtn").click(function () {
        resetForm();
        fetchFaculty();
    });
});

/* -----------------------------------------
        LOAD FACULTY INTO DROPDOWN
------------------------------------------*/
function loadFaculty() {

    $.ajax({
        url: "../facultyServlet",
        method: "GET",
        dataType: "json",
        success: function (data) {
            facultyData = data;
            $("#facultyDropdown").empty().append(new Option("Select Faculty", ""));

            data.forEach(function (f) {
                const label = `${f.name} - ${f.facultyID}`;
                $("#facultyDropdown").append(new Option(label, f.id));
            });
        },
        error: function () {
            showToast("Error loading faculty list", true);
        }
    });
}

/* -----------------------------------------
          FETCH PROFILE (ADMIN)
------------------------------------------*/
function fetchFaculty() {
    const id = $("#facultyDropdown").val();
    if (!id) return showToast("Select a faculty", true);

    $("#profileLoading").removeClass("d-none");
    $("#profileContainer").hide();

    $.ajax({
        url: "../GetFacultyProfile",
        method: "POST",
        data: { facultyId: id },
        dataType: "json",
        success: function (data) {
            if (data.error) return showToast(data.error, true);

            populateFaculty(data);
            ensureReadonly();

            $("#profileLoading").addClass("d-none");
            $("#profileContainer").fadeIn();
        },
        error: function () {
            showToast("Error fetching faculty profile", true);
        }
    });
}

/* -----------------------------------------
   FETCH PROFILE FOR FACULTY (SESSION)
------------------------------------------*/
function fetchFacultyFromSession() {
    $("#profileLoading").removeClass("d-none");
    $("#profileContainer").hide();

    $.ajax({
        url: "../GetFacultyProfile",
        method: "POST",
        data: {},
        dataType: "json",
        success: function (data) {
            if (data.error) return showToast(data.error, true);

            populateFaculty(data);
            ensureReadonly();
            hideEditControls();

            $("#profileLoading").addClass("d-none");
            $("#profileContainer").fadeIn();
        },
        error: function () {
            showToast("Error fetching faculty profile", true);
        }
    });
}

/* -----------------------------------------
            POPULATE UI FIELDS
------------------------------------------*/
function populateFaculty(data) {

    // Basic Info
    $("#facultyId").val(data.id || "");
    $("#facultyID").val(data.facultyID || "");
    $("#facultyIDDisplay").text(data.facultyID || "FAC-ID");

    const name = data.name || "";
    $("#name").val(name);
    $("#facultyNameHeader").text(name || "Faculty Name");

    $("#email").val(data.email || "");
    $("#phone_number").val(data.phone_number || "");
    $("#aadhar_number").val(data.aadhar_number || "");
    $("#gender").val(data.gender || "");
    $("#dob").val(data.dob || "");

    // Age Calculation
    if (data.dob) {
        const birth = new Date(data.dob);
        const age = new Date().getFullYear() - birth.getFullYear();
        $("#age").val(age);
    }

    // Professional
    $("#qualification").val(data.qualification || "");
    $("#department").val(data.department || "");
    $("#designation").val(data.designation || "");
    $("#experience_years").val(data.experience_years || "");
    $("#join_date").val(data.join_date || "");

    // Get Annual Salary from DB (data.salary)
    const annualSalary = data.salary ? Number(data.salary) : 0;

    // --- Display Annual Salary as is ---
    $("#salary").val(
        annualSalary > 0
            ? "₹" + annualSalary.toLocaleString("en-IN")
            : "₹0"
    );

    // --- Monthly Calculation (Annual / 12) ---
    let monthlySalary = 0;

    if (annualSalary > 0) {
        monthlySalary = annualSalary / 12;

        $("#monthly_salary").val(
            "₹" +
            monthlySalary.toLocaleString("en-IN", {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            })
        );
    } else {
        $("#monthly_salary").val("₹0");
    }

    $("#status").val(data.status || "");

    // Address
    $("#address").val(data.address || "");
    $("#city").val(data.city || "");
    $("#state").val(data.state || "");
    $("#pincode").val(data.pincode || "");

    // Avatar
    if (data.photo && data.photo !== "") {
        $("#avatarPreview").attr("src", data.photo);
    } else {
        const initials = generateInitials(name);
        $("#avatarPreview").attr("src", generateAvatarInitials(initials));
    }

    /* -----------------------------------------
         Extra Section: Subjects Taught (Static)
    -------------------------------------------*/
    const subjects = data.subjects || ["Mathematics", "Physics", "English"];
    $("#subjectsList").html("");
    subjects.forEach(sub => {
        $("#subjectsList").append(`<span class="badge bg-primary me-1">${sub}</span>`);
    });

    /* -----------------------------------------
         Extra Section: Class Teacher (Static)
    -------------------------------------------*/
    $("#classTeacherOf").text(data.class_teacher_for || "8th Grade - B Section");

    /* -----------------------------------------
         Extra Section: Timetable (Static)
    -------------------------------------------*/
    const timetable = data.timetable || [
        { time: "08:00 - 09:00", subject: "Math" },
        { time: "09:00 - 10:00", subject: "Physics" },
        { time: "10:00 - 11:00", subject: "English" }
    ];

    $("#timetableBody").html("");
    timetable.forEach(t => {
        $("#timetableBody").append(`
            <tr>
                <td>${t.time}</td>
                <td>${t.subject}</td>
            </tr>
        `);
    });

    /* -----------------------------------------
         Extra Section: Documents (Static)
    -------------------------------------------*/
    const documents = data.documents || [
        { name: "Aadhaar", status: "Uploaded" },
        { name: "PAN Card", status: "Not Uploaded" },
        { name: "Degree Certificate", status: "Uploaded" }
    ];

    $("#documentsBody").html("");
    documents.forEach(doc => {
        $("#documentsBody").append(`
            <tr>
                <td>${doc.name}</td>
                <td>${doc.status}</td>
            </tr>
        `);
    });
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