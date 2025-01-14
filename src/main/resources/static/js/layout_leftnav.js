    $(document).ready(function() {
        $.ajax({
            url: 'layout_memberInfo',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                 $('#memberName').text(data.empl_name);  // Update name
       	 		 $('#memberDept').text(data.dept_name + '/' + data.duty_name);  // Update dept and duty
        		 $('#profileImage').attr('src', 'memberFiles/' + data.empl_profile);  // Update profile image src
        console.log(data);  // Log the response to see the data
            },
            error: function(xhr, status, error) {
                console.error("Error fetching member info: " + error);
            }
        });
    });