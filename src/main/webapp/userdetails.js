document.addEventListener('DOMContentLoaded', function() {
    var customerRows = document.querySelectorAll('#customerTable tbody tr');
    customerRows.forEach(function(row) {
        row.addEventListener('click', function() {
            var customerId = row.getAttribute('data-customer-id');
            var name = row.getAttribute('data-name');
            var age = row.getAttribute('data-age');
            var email = row.getAttribute('data-email');
            var phone = row.getAttribute('data-phone');
            var password = row.getAttribute('data-password');
            var address = row.getAttribute('data-address');
            var pincode = row.getAttribute('data-pincode');
            
            document.getElementById('customerName').innerText = name;
            document.getElementById('customerAge').innerText = age;
            document.getElementById('customerEmail').innerText = email;
            document.getElementById('customerPhone').innerText = phone;
            document.getElementById('customerPassword').innerText = password;
            document.getElementById('customerAddress').innerText = address;
            document.getElementById('customerPincode').innerText = pincode;

            document.getElementById('customerDetails').style.display = 'block';
        });
    });
});
