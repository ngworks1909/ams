// document.addEventListener('DOMContentLoaded', function() {
//     const loginForm = document.getElementById('loginForm');
//     const loginBtn = document.getElementById('loginBtn');
//     const messageContainer = document.getElementById('messageContainer');
    
//     // Array of possible error messages
//     const errorMessages = [
//         'Invalid username or password. Please try again.',
//         'Account not found. Please check your credentials.',
//         'Too many failed attempts. Please try again later.',
//         'Network error. Please check your connection.',
//         'Server is temporarily unavailable. Please try again.',
//         'Session expired. Please login again.',
//         'Invalid user ID format. Please enter a valid ID.'
//     ];
    
//     // Array of possible success messages
//     const successMessages = [
//         'Login successful! Redirecting to dashboard...',
//         'Welcome back! Loading your account...',
//         'Authentication successful! Please wait...',
//         'Login completed successfully!',
//         'Access granted! Preparing your workspace...'
//     ];
    
//     // Function to show message
    // function showMessage(message, type) {
    //     // Clear any existing messages
    //     messageContainer.innerHTML = '';
        
    //     // Create message element
    //     const messageElement = document.createElement('div');
    //     messageElement.className = `message ${type}`;
    //     messageElement.textContent = message;
        
    //     // Add message to container
    //     messageContainer.appendChild(messageElement);
        
    //     // Auto-hide message after 5 seconds
    //     setTimeout(() => {
    //         if (messageElement.parentNode) {
    //             messageElement.style.opacity = '0';
    //             messageElement.style.transform = 'translateY(-10px)';
    //             setTimeout(() => {
    //                 if (messageElement.parentNode) {
    //                     messageContainer.removeChild(messageElement);
    //                 }
    //             }, 300);
    //         }
    //     }, 5000);
    // }
    
//     // Function to show loading state
//     function showLoading() {
//         const originalText = loginBtn.innerHTML;
//         loginBtn.innerHTML = '<span class="spinner"></span>Processing...';
//         loginBtn.disabled = true;
        
//         return function hideLoading() {
//             loginBtn.innerHTML = originalText;
//             loginBtn.disabled = false;
//         };
//     }
    
//     // Handle form submission
//     loginForm.addEventListener('submit', function(e) {
//         e.preventDefault(); // Prevent default form submission
        
//         // Get form values
//         const userid = document.getElementById('userid').value.trim();
//         const password = document.getElementById('password').value.trim();
        
//         // Basic validation
//         if (!userid || !password) {
//             showMessage('Please fill in all fields.', 'error');
//             return;
//         }
        
//         // Show loading state
//         const hideLoading = showLoading();
        
//         // Simulate API call delay
//         setTimeout(() => {
//             hideLoading();
            
//             // Randomly choose success or error (50% chance each)
//             const isSuccess = Math.random() > 0.5;
            
//             if (isSuccess) {
//                 // Show random success message
//                 const randomSuccess = successMessages[Math.floor(Math.random() * successMessages.length)];
//                 showMessage(randomSuccess, 'success');
                
//                 // Optional: Clear form on success
//                 setTimeout(() => {
//                     loginForm.reset();
//                 }, 2000);
                
//             } else {
//                 // Show random error message
//                 const randomError = errorMessages[Math.floor(Math.random() * errorMessages.length)];
//                 showMessage(randomError, 'error');
//             }
            
//         }, 1500); // 1.5 second delay to simulate network request
//     });
    
//     // Clear messages when user starts typing
//     document.getElementById('userid').addEventListener('input', clearMessages);
//     document.getElementById('password').addEventListener('input', clearMessages);
    
//     function clearMessages() {
//         const messages = messageContainer.querySelectorAll('.message');
//         messages.forEach(message => {
//             message.style.opacity = '0';
//             message.style.transform = 'translateY(-10px)';
//             setTimeout(() => {
//                 if (message.parentNode) {
//                     messageContainer.removeChild(message);
//                 }
//             }, 300);
//         });
//     }
// });


const map = new Map()

map.set('123', {userId: '123', password: 'nithin', name: "Nithin"})
map.set('456', {userId: '456', password: 'charan', name: "Sai Charan"})
map.set('789', {userId: '789', password: 'jagadeesh', name: "Jagadeesh"})

const user = document.getElementById('userid');
const password = document.getElementById('password');

function showMessage(message, type) {
    messageContainer.innerHTML = '';
    
    const messageElement = document.createElement('div');
    messageElement.className = `message ${type}`;
    messageElement.textContent = message;
    
    messageContainer.appendChild(messageElement);
    
    setTimeout(() => {
        if (messageElement.parentNode) {
            messageElement.style.opacity = '0';
            messageElement.style.transform = 'translateY(-10px)';
            setTimeout(() => {
                if (messageElement.parentNode) {
                    messageContainer.removeChild(messageElement);
                }
            }, 300);
        }
    }, 5000);
}


function validateUser(userid){
     return /^[1-9][0-9]{0,4}$/.test(userid);
}

function validatePassword(password){
    if(password.length < 6 || password.length > 30) return false
    return true

}


function submit(event){
    event.preventDefault();
    if(!user.value || !validateUser(user.value)){
        showMessage('ID not valid', 'error')
        return
    }
    if(!password.value || !validatePassword(password.value)){
        showMessage('Password not valid', 'error')
        return
    }

    const record = map.get(user.value);

    if(!record){
        showMessage('Invalid ID/Password', 'error')
        return
    }

    if(record.password !== password.value){
        showMessage('Invalid ID/Password', 'error')
        return
    }

    showMessage('Login successful!', 'success')
    setTimeout(() => {
        localStorage.setItem('user', JSON.stringify({username: record.username}))
        window.location.href = 'home.html'
    }, 4000);


}


document.getElementById('loginForm').addEventListener('submit', submit)