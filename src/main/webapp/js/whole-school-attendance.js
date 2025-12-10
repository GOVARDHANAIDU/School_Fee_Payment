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
