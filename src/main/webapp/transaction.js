// feedback.js

document.addEventListener("DOMContentLoaded", function() {
    console.log("Page loaded and DOM fully constructed.");
    
    // Add any required JavaScript functionality here
    // For example, adding event listeners or handling form submissions
    
    // Example function to highlight a row when clicked
    document.querySelectorAll('#customerTable tbody tr').forEach(row => {
        row.addEventListener('click', function() {
            alert('Transaction ID: ' + this.cells[0].innerText);
        });
    });
});
