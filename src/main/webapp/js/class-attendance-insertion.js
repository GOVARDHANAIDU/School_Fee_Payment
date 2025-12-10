let attendanceData = {};
document.addEventListener("DOMContentLoaded", () => {
    const btn = document.getElementById("reviewBtn");
    if (btn) {
        function checkAll() {
            let all = true;
            document.querySelectorAll("#tableBody tr").forEach(tr => {
                if (!tr.querySelector("input[type='radio']:checked")) all = false;
            });
            btn.disabled = !all;
        }
        document.querySelectorAll("input[type='radio']").forEach(r => {
            r.addEventListener("change", checkAll);
        });
        // Initialize default active states for P (green)
        document.querySelectorAll(".radio-group").forEach(group => {
            const labels = group.querySelectorAll("label");
            if (labels.length >= 2) {
                const pLabel = labels[0]; // First label is P
                const pInput = pLabel.previousElementSibling;
                if (pInput && pInput.checked) {
                    updateStatus(pLabel);
                }
            }
        });
        checkAll();
    }
});
function updateStatus(label) {
    const radio = label.previousElementSibling;
    label.parentElement.querySelectorAll("label")
        .forEach(l => {
            l.classList.remove("present-active", "absent-active");
        });
    if (radio && radio.value === "P") {
        label.classList.add("present-active");
    } else if (radio && radio.value === "A") {
        label.classList.add("absent-active");
    }
}
function openAbsenteeModal() {
    attendanceData = {};
    document.querySelectorAll("tr[data-admin-no]").forEach(tr => {
        const admin = tr.dataset.adminNo;
        const status = tr.querySelector("input[type='radio']:checked").value;
        attendanceData[admin] = { status };
    });
    const absent = Object.keys(attendanceData)
        .filter(a => attendanceData[a].status === "A");
    const modal = new bootstrap.Modal(document.getElementById("absenteeModal"), {
        backdrop: 'static',
        keyboard: false
    });
    const container = document.getElementById("absenteeForms");
    container.innerHTML = "";
    if (absent.length === 0) { 
        generatePreview(); 
        return; 
    }
    absent.forEach(admin => {
        const row = document.querySelector(`tr[data-admin-no="${admin}"]`);
        const name = row.querySelector("[data-label='Student']").innerText;
        const div = document.createElement("div");
        div.className = "absentee-form card mb-3";
        div.innerHTML = `
            <div class="card-header bg-light">
                <h6 class="mb-0 fw-bold">${name}</h6>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <label class="form-label">Type:</label>
                        <select class="form-select form-select-sm" id="subtype_${admin}">
                            <option value="">Select</option>
                            <option value="HD">Half Day</option>
                            <option value="L">Leave</option>
                        </select>
                    </div>
                    <div class="col-md-6" id="leaveTypeDiv_${admin}" style="display:none;">
                        <label class="form-label">Leave Type:</label>
                        <select class="form-select form-select-sm" id="leave_type_${admin}">
                            <option value="MEDICAL">Medical</option>
                            <option value="OTHER">Other</option>
                        </select>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <label class="form-label">Reason:</label>
                        <textarea id="reason_${admin}" class="form-control form-control-sm" rows="2" placeholder="Enter reason for absence..."></textarea>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <label class="form-label">Document (optional):</label>
                        <input type="file" class="form-control form-control-sm" id="file_${admin}" accept=".pdf,.jpg,.jpeg,.png">
                    </div>
                </div>
            </div>
        `;
        container.appendChild(div);
        // Event listener for subtype change
        document.getElementById(`subtype_${admin}`).addEventListener("change", e => {
            const leaveDiv = document.getElementById(`leaveTypeDiv_${admin}`);
            leaveDiv.style.display = e.target.value === "L" ? "block" : "none";
        });
        // Restore values if editing
        const subtypeSelect = document.getElementById(`subtype_${admin}`);
        const existingSubtype = attendanceData[admin].subtype || '';
        subtypeSelect.value = existingSubtype;
        const leaveDiv = document.getElementById(`leaveTypeDiv_${admin}`);
        if (existingSubtype === 'L') {
            leaveDiv.style.display = 'block';
            const leaveTypeSelect = document.getElementById(`leave_type_${admin}`);
            leaveTypeSelect.value = attendanceData[admin].leave_type || 'MEDICAL';
        }
        document.getElementById(`reason_${admin}`).value = attendanceData[admin].reason || '';
    });
    modal.show();
}
function generatePreview() {
    // Update attendance data from forms for absentees, aligning with DB schema
    Object.keys(attendanceData).forEach(admin => {
        if (attendanceData[admin].status === 'A') {
            const subtypeEl = document.getElementById(`subtype_${admin}`);
            const subtype = subtypeEl ? subtypeEl.value : '';
            attendanceData[admin].subtype = subtype;
            let type = '';
            if (subtype === 'HD') {
                // Override status to 'HD' for schema compliance
                attendanceData[admin].status = 'HD';
                attendanceData[admin].leave_type = null;
                type = 'HD';
            } else if (subtype === 'L') {
                // Keep 'A', set valid ENUM leave_type
                const ltEl = document.getElementById(`leave_type_${admin}`);
                const lt = ltEl ? ltEl.value : 'OTHER';
                attendanceData[admin].leave_type = lt; // 'MEDICAL' or 'OTHER'
                type = `Leave (${lt})`;
            } else {
                // No subtype selected: plain 'A'
                attendanceData[admin].leave_type = null;
                type = 'A';
            }
            attendanceData[admin].type = type;
            const reasonEl = document.getElementById(`reason_${admin}`);
            attendanceData[admin].reason = reasonEl ? reasonEl.value : '';
            // For document preview
            const fileInput = document.getElementById(`file_${admin}`);
            if (fileInput && fileInput.files[0]) {
                attendanceData[admin].document_name = fileInput.files[0].name;
            } else {
                attendanceData[admin].document_name = attendanceData[admin].document_name || 'N/A';
            }
        }
    });
    const container = document.getElementById("previewBody");
    container.innerHTML = "";
    for (let admin in attendanceData) {
        const d = attendanceData[admin];
        const row = document.querySelector(`tr[data-admin-no="${admin}"]`);
        const name = row.querySelector("[data-label='Student']").innerText;
        const tr = document.createElement("tr");
        tr.innerHTML = `
            <td>${name}</td>
            <td>${d.status}</td>
            <td>${d.type || "-"}</td>
            <td>${d.reason || "-"}</td>
            <td>${d.document_name || "N/A"}</td>
        `;
        container.appendChild(tr);
    }
    bootstrap.Modal.getInstance(document.getElementById("absenteeModal")).hide();
    const previewModal = new bootstrap.Modal(document.getElementById("previewModal"), {
        backdrop: 'static',
        keyboard: false
    });
    previewModal.show();
}
function saveAllAttendance() {
    const formData = new FormData();
    formData.append("date", document.getElementById("datePicker").value);
    formData.append("selectedClass", document.getElementById("classSelect").value);
    let hasData = false;
    for (let admin in attendanceData) {
        let d = attendanceData[admin];
        formData.append("status_" + admin, d.status);
        if (d.reason) formData.append("reason_" + admin, d.reason);
        if (d.leave_type && d.status === 'A') { // Only for 'A' with valid ENUM
            formData.append("leave_type_" + admin, d.leave_type);
        }
        const fileInput = document.getElementById("file_" + admin);
        if (fileInput && fileInput.files[0]) {
            formData.append("document_" + admin, fileInput.files[0]);
        }
        hasData = true;
    }
    if (!hasData) {
        alert("No attendance data to save.");
        return;
    }
    // Use absolute path to avoid 404; adjust '/yourApp' if context path differs
    fetch(window.location.origin + "/AttendanceServlet", { // Absolute path from root
        method: "POST",
        body: formData
    })
    .then(r => {
        if (!r.ok) throw new Error(`HTTP ${r.status}: ${r.statusText}`);
        return r.text();
    })
    .then(res => {
        if (res === "SUCCESS") {
            alert("Attendance Saved Successfully!");
            location.reload();
        } else if (res === "DUPLICATE") {
            alert("Attendance already marked for this class & date.");
        } else {
            alert("Error saving attendance: " + res);
        }
    })
    .catch(err => {
        console.error("Fetch error:", err);
        alert("Network error: " + err.message + ". Check server logs.");
    });
}
function saveAllAttendance() {
    const formData = new FormData();
    formData.append("date", document.getElementById("datePicker").value);
    formData.append("selectedClass", document.getElementById("classSelect").value);
    let hasData = false;
    for (let admin in attendanceData) {
        let d = attendanceData[admin];
        formData.append("status_" + admin, d.status);
        if (d.reason) formData.append("reason_" + admin, d.reason);
        if (d.leave_type && d.status === 'A') {
            formData.append("leave_type_" + admin, d.leave_type);
        }
        const fileInput = document.getElementById("file_" + admin);
        if (fileInput && fileInput.files[0]) {
            formData.append("document_" + admin, fileInput.files[0]);
        }
        hasData = true;
    }
    if (!hasData) {
        alert("No attendance data to save.");
        return;
    }
    // Dynamic context path (adjust if your app context is e.g. '/school')
    const contextPath = window.location.pathname.split('/')[1]; // Extracts 'school' or similar
    const servletUrl = `/${contextPath}/AttendanceServlet`;
    fetch(servletUrl, {
        method: "POST",
        body: formData
    })
    .then(r => {
        if (!r.ok) throw new Error(`HTTP ${r.status}: ${r.statusText}`);
        return r.text();
    })
    .then(res => {
        if (res === "SUCCESS") {
            alert("Attendance Saved Successfully!");
            location.reload();
        } else if (res === "DUPLICATE") {
            alert("Attendance already marked for this class & date.");
        } else {
            alert("Error saving attendance: " + res);
        }
    })
    .catch(err => {
        console.error("Fetch error:", err);
        alert("Network error: " + err.message + ". Check server logs.");
    });
}