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
        const statusRadio = tr.querySelector("input[type='radio']:checked");
        if (statusRadio) {
            attendanceData[admin] = { status: statusRadio.value };
        }
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
                <small class="text-muted">Admin No: ${admin}</small>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <label class="form-label">Absence Type:</label>
                        <select class="form-select form-select-sm" id="subtype_${admin}">
                            <option value="">Select Type</option>
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
                        <small class="text-muted">Max 5MB</small>
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
    });
    
    modal.show();
}

function generatePreview() {
    // Update attendance data from forms for absentees
    Object.keys(attendanceData).forEach(admin => {
        if (attendanceData[admin].status === 'A') {
            const subtypeEl = document.getElementById(`subtype_${admin}`);
            const subtype = subtypeEl ? subtypeEl.value : '';
            
            if (subtype === 'HD') {
                // Override status to 'HD' for half day
                attendanceData[admin].status = 'HD';
                attendanceData[admin].leave_type = null;
                attendanceData[admin].type = 'Half Day';
            } else if (subtype === 'L') {
                // Keep 'A', set leave_type
                const leaveTypeEl = document.getElementById(`leave_type_${admin}`);
                const leaveType = leaveTypeEl ? leaveTypeEl.value : 'OTHER';
                attendanceData[admin].leave_type = leaveType;
                attendanceData[admin].type = `Leave (${leaveType})`;
            } else {
                // Plain absence (no subtype selected)
                attendanceData[admin].leave_type = null;
                attendanceData[admin].type = 'Absent';
            }
            
            // Get reason
            const reasonEl = document.getElementById(`reason_${admin}`);
            attendanceData[admin].reason = reasonEl ? reasonEl.value : '';
            
            // Handle document
            const fileInput = document.getElementById(`file_${admin}`);
            if (fileInput && fileInput.files[0]) {
                attendanceData[admin].document_file = fileInput.files[0];
                attendanceData[admin].document_name = fileInput.files[0].name;
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
            <td>${admin}</td>
            <td><span class="badge ${d.status === 'P' ? 'bg-success' : d.status === 'HD' ? 'bg-warning' : 'bg-danger'}">${d.status}</span></td>
            <td>${d.type || "-"}</td>
            <td>${d.reason ? d.reason.substring(0, 50) + (d.reason.length > 50 ? "..." : "") : "-"}</td>
            <td>${d.document_name ? `<span class="badge bg-info">${d.document_name}</span>` : "No Document"}</td>
        `;
        container.appendChild(tr);
    }
    
    const absenteeModal = bootstrap.Modal.getInstance(document.getElementById("absenteeModal"));
    if (absenteeModal) {
        absenteeModal.hide();
    }
    
    const previewModal = new bootstrap.Modal(document.getElementById("previewModal"), {
        backdrop: 'static',
        keyboard: false
    });
    previewModal.show();
}

function saveAllAttendance() {
    const formData = new FormData();
    const dateInput = document.getElementById("datePicker");
    const classInput = document.getElementById("classSelect");
    
    
	// Instead of: alert("Please select a date!");
		
    formData.append("date", dateInput.value);
    formData.append("selectedClass", classInput.value);
    
    let hasData = false;
    for (let admin in attendanceData) {
        let d = attendanceData[admin];
        
        // Always send status
        formData.append("status_" + admin, d.status);
        
        // Send reason if exists
        if (d.reason) {
            formData.append("reason_" + admin, d.reason);
        }
        
        // Send leave_type only if it's 'A' with leave_type (not HD)
        if (d.status === 'A' && d.leave_type) {
            formData.append("leave_type_" + admin, d.leave_type);
        }
        
        // Send document file if exists
        if (d.document_file) {
            formData.append("document_" + admin, d.document_file);
        }
        
        hasData = true;
    }
    
    if (!hasData) {
        alert("No attendance data to save.");
        return;
    }
    
    // ============================================
    // FIXED: ABSOLUTE URL FOR /secure CONTEXT PATH
    // ============================================
    
    // Your servlet is at: /secure/AttendanceServlet
    const servletUrl = "/SchoolData/AttendanceServlet";
    
    // Show loading indicator
    const saveBtn = document.getElementById("saveBtn");
    const originalText = saveBtn ? saveBtn.innerHTML : "Save";
    if (saveBtn) {
        saveBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...';
        saveBtn.disabled = true;
    }
    
    // Send the request
    fetch(servletUrl, {
        method: "POST",
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
        return response.text();
    })
    .then(result => {
        console.log("Server response:", result);
        
        const trimmedResult = result.trim();
        
        if (trimmedResult === "SUCCESS") {
			// Instead of: alert("Attendance saved successfully!");
			showSuccessToast("Attendance saved successfully!");

		
            // Close modal
            const previewModal = bootstrap.Modal.getInstance(document.getElementById("previewModal"));
            if (previewModal) {
                previewModal.hide();
            }
            
            // Reload page after short delay
            setTimeout(() => {
                location.reload();
            }, 1000);
            
        } else if (trimmedResult === "DUPLICATE") {
			showWarningToast("Attendance for this class and date already exists. Please select a different date.");

			        } else if (trimmedResult.startsWith("ERROR:")) {
            alert("❌ " + trimmedResult);
        } else {
            alert("❌ Unknown error: " + trimmedResult);
        }
    })
    .catch(error => {
        console.error("Error saving attendance:", error);
		// Instead of: alert("Error: " + error.message);
				showErrorToast("Failed to save attendance. Please check your connection." + error.message);

				// For loading states:
				const loadingToast = showLoadingToast("Saving attendance...");
    })
    .finally(() => {
        // Restore button state
        if (saveBtn) {
            saveBtn.innerHTML = originalText;
            saveBtn.disabled = false;
        }
    });
}

// Function to test connection (for debugging)
function testServletConnection() {
    console.log("=== Testing Servlet Connection ===");
    console.log("Current URL:", window.location.href);
    console.log("Current path:", window.location.pathname);
    console.log("Context path should be: /SchoolData");
    
    // Test the absolute URL
    const testUrl = "/SchoolData/AttendanceServlet";
    console.log("Testing URL:", testUrl);
    
    const testFormData = new FormData();
    testFormData.append("test", "1");
    
    fetch(testUrl, {
        method: 'POST',
        body: testFormData
    })
    .then(r => {
        console.log(`Status: ${r.status}`);
        return r.text();
    })
    .then(text => {
        console.log(`Response: ${text}`);
    })
    .catch(err => {
        console.log(`Error: ${err.message}`);
        console.log("If you see CORS error, the URL might be wrong.");
        console.log("Trying alternative: /AttendanceServlet");
        
        // Try without context path
        fetch("/AttendanceServlet", {
            method: 'POST',
            body: testFormData
        })
        .then(r => console.log("Alternative status:", r.status))
        .catch(e => console.log("Alternative error:", e.message));
    });
}

// Add event listeners
document.addEventListener("DOMContentLoaded", function() {
    const saveBtn = document.getElementById("saveBtn");
    if (saveBtn) {
        saveBtn.addEventListener("click", saveAllAttendance);
    }
    
    // Optional: Debug button (add this HTML if needed)
    // <button onclick="testServletConnection()" class="btn btn-secondary btn-sm">Test Connection</button>
    
    // Uncomment for debugging:
    // console.log("=== Debug Information ===");
    // console.log("Window location:", window.location);
    // console.log("Context path should be: /secure");
    // console.log("Servlet URL should be: /secure/AttendanceServlet");
    // testServletConnection();
});


// Toast notification functions
function showToast(type, message) {
    const toastEl = document.getElementById(`${type}Toast`);
    const messageEl = document.getElementById(`${type}Message`);
    
    if (toastEl && messageEl) {
        messageEl.textContent = message;
        const toast = new bootstrap.Toast(toastEl, {
            animation: true,
            autohide: true,
            delay: 5000
        });
        toast.show();
    } else {
        // Fallback to alert if toast elements not found
        console.error(`Toast element not found for type: ${type}`);
        alert(message);
    }
}

// Quick helper functions for common toast types
function showSuccessToast(message) {
    showToast('success', message);
}

function showErrorToast(message) {
    showToast('error', message);
}

function showWarningToast(message) {
    showToast('warning', message);
}

function showInfoToast(message) {
    showToast('info', message);
}

// Loading toast function (custom)
function showLoadingToast(message = "Processing...") {
    // Create a custom loading toast
    const toastContainer = document.querySelector('.toast-container');
    if (!toastContainer) {
        console.warn('Toast container not found');
        return null;
    }
    
    const toastId = 'loadingToast_' + Date.now();
    const loadingToast = document.createElement('div');
    loadingToast.id = toastId;
    loadingToast.className = 'toast bg-primary text-white';
    loadingToast.innerHTML = `
        <div class="toast-body d-flex align-items-center">
            <div class="spinner-border spinner-border-sm me-3" role="status"></div>
            <span>${message}</span>
        </div>
    `;
    
    toastContainer.appendChild(loadingToast);
    const toast = new bootstrap.Toast(loadingToast, { 
        autohide: false 
    });
    toast.show();
    
    return {
        hide: () => {
            toast.hide();
            setTimeout(() => {
                if (loadingToast.parentNode) {
                    loadingToast.parentNode.removeChild(loadingToast);
                }
            }, 500);
        },
        updateMessage: (newMessage) => {
            const span = loadingToast.querySelector('span');
            if (span) span.textContent = newMessage;
        }
    };
}