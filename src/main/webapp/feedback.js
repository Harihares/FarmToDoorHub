document.addEventListener('DOMContentLoaded', function() {
    var customerRows = document.querySelectorAll('#customerTable tbody tr');
    customerRows.forEach(function(row) {
        row.addEventListener('click', function() {
            var customerId = row.getAttribute('data-customer-id');
            var productId = row.getAttribute('data-product-id');
            var feedback = row.getAttribute('data-feedback');
            
            
            document.getElementById('customerId').innerText = customerId;
            document.getElementById('productId').innerText = productId;
            document.getElementById('feedback').innerText = feedback;
            
            document.getElementById('feedback').style.display = 'block';
        });
    });
});
