// ================= APPLY FILTERS =================
document.addEventListener("DOMContentLoaded", () => {

    const dateInput = document.getElementById("filterDate");
    const classInput = document.getElementById("filterClass");
    const statusInput = document.getElementById("filterStatus");
    const filterBtn = document.getElementById("applyFilters");

    function applyFilters() {
        const date = dateInput.value || "";
        const cls = classInput.value || "";
        const status = statusInput.value || "";

        const url = `?date=${date}&class=${cls}&status=${status}`;
        window.location.href = url;
    }

    filterBtn.addEventListener("click", applyFilters);

    // Auto-apply when dropdown changes
    dateInput.addEventListener("change", applyFilters);
    classInput.addEventListener("change", applyFilters);
    statusInput.addEventListener("change", applyFilters);

});

// ================= DATATABLE =================
$(document).ready(function () {

    const table = $('#attendanceTable').DataTable({
        responsive: true,
        pageLength: 10,
        ordering: true,
        dom: 'Bfrtip',
        buttons: [
            {
                extend: 'excelHtml5',
                text: 'Excel',
                className: 'btn btn-success btn-sm'
            },
            {
                extend: 'pdfHtml5',
                text: 'PDF',
                className: 'btn btn-success btn-sm'
            }
        ],
        initComplete: function () {
            table.buttons().container().appendTo('.dt-buttons');
        }
    });

});



// Update the DataTables initialization with better column visibility
$(document).ready(function() {
    // Initialize DataTable with column names for show/hide
    const table = $('#attendanceTable').DataTable({
        responsive: true,
        pageLength: 10,
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
        order: [[2, 'asc']],
        dom: 'lfrtip',
        buttons: [
            { 
                extend: 'excelHtml5', 
                text: '<i class="bi bi-file-excel me-1"></i>Excel', 
                title: 'Attendance_Report_' + new Date().toISOString().split('T')[0],
                className: 'btn-sm'
            },
            { 
                extend: 'colvis', 
                text: '<i class="bi bi-columns-gap me-1"></i>Show/Hide',
                className: 'btn-sm',
                // Customize column names in dropdown
                columns: ':not(.noVis)',
                columnText: function(dt, idx, title) {
                    // Map column indices to readable names
                    const columnNames = {
                        0: 'S.No',
                        1: 'Admin No',
                        2: 'Student Name',
                        3: 'Class',
                        4: 'Status',
                        5: 'Leave Type',
                        6: 'Reason',
                        7: 'Date',
                        8: 'Time',
                        9: 'Document'
                    };
                    return (idx < 10) ? columnNames[idx] : title;
                },
                // Show dropdown menu
                dropup: true
            }
        ],
        language: {
            search: "Search:",
            lengthMenu: "Show _MENU_ entries per page"
        },
        // Wrap table in responsive container
        initComplete: function() {
            // Add responsive wrapper
            $('.dataTables_wrapper').addClass('table-responsive');
            
            // Move buttons to header
            if (this.buttons && this.buttons().container) {
                this.buttons().container().appendTo('.dt-buttons');
            }
        },
        drawCallback: function(settings) {
            // Fix column visibility dropdown styling
            $('.dt-button-collection').addClass('dropdown-menu');
            $('.buttons-colvis').addClass('dropdown-toggle');
        }
    });

    // Download Report Button functionality
    $('#downloadReportBtn').on('click', function() {
        // Trigger Excel download
        $('.buttons-excel').click();
        
        // Optional: Show confirmation
        $(this).html('<i class="bi bi-check-circle me-1"></i> Downloading...');
        setTimeout(() => {
            $(this).html('<i class="bi bi-download me-1"></i> Download Report');
        }, 2000);
    });

    // Fix column visibility dropdown on mobile
    $(document).on('click', '.buttons-colvis', function(e) {
        if ($(window).width() < 768) {
            $('.dt-button-collection').css({
                'position': 'fixed',
                'top': '50%',
                'left': '50%',
                'transform': 'translate(-50%, -50%)',
                'z-index': 1050,
                'max-height': '70vh',
                'overflow-y': 'auto'
            });
        }
    });
});


// Mobile-specific fixes
function fixMobileLayout() {
    if ($(window).width() < 768) {
        // Wrap table in responsive container
        if (!$('#attendanceTable_wrapper').hasClass('table-responsive')) {
            $('#attendanceTable_wrapper').addClass('table-responsive');
        }
        
        // Fix dropdown menu overflow
        $('.dropdown-menu').css({
            'max-height': '60vh',
            'overflow-y': 'auto'
        });
        
        // Adjust chart container heights
        $('.chart-container').css('height', '180px');
    } else {
        // Reset for desktop
        $('.chart-container').css('height', '200px');
    }
}

// Call on load and resize
$(window).on('load resize', fixMobileLayout);