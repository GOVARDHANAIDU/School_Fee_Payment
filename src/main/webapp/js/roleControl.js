// roleControl.js

document.addEventListener("DOMContentLoaded", hideFunction);

function hideFunction() {
    const role = window.userRole || "guest";
    console.log("Detected role:", role);

    // ✅ Hide all elements that have id="hideFunction"
    const elementsToHide = document.querySelectorAll('#hideFunction');
    elementsToHide.forEach(el => {
        el.style.display = 'none';
        console.log('Hiding element with id="hideFunction":', el);
    });

    // ✅ Role-based UI restrictions
    if (role === "student" || role === "faculty") {
        // Hide "Payments" dropdown
        const paymentsLink = Array.from(document.querySelectorAll('.nav-link'))
            .find(link => link.textContent.trim() === 'Payments');
        if (paymentsLink && paymentsLink.closest('.nav-item')) {
            paymentsLink.closest('.nav-item').style.display = 'none';
        }

        // Hide "Send Notifications" link
        const notificationsLink = document.querySelector('a[href="fee-notifications.jsp"]');
        if (notificationsLink && notificationsLink.closest('.nav-item')) {
            notificationsLink.closest('.nav-item').style.display = 'none';
        }
    }
}


// role-restriction.js (Separate file for role-based logic)
document.addEventListener("DOMContentLoaded", function () {
    const role = window.userRole || "guest";
    const admissionNo = window.admissionNo || null; // Optional, for logging
    console.log("🎯 Detected Role:", role, "| Admission No:", admissionNo);
    // === If logged-in user is a student ===
    if (role === "student") {
        console.log("👨‍🎓 Student logged in, showing only their profile.");
        // Hide dropdown
        $('#studentDropdown').prop('disabled', true).parent().hide();
        // Directly fetch from session (no params needed; servlet uses session admissionNo)
        fetchStudentFromSession();
    }
});