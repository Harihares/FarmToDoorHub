1

document.addEventListener("DOMContentLoaded", function() {
    const chatbotContainer = document.getElementById('chatbot-container');
    const chatbotMessages = document.getElementById('chatbot-messages');
    const chatbotInput = document.getElementById('chatbot-input');
    const chatbotSendButton = document.getElementById('chatbot-send-button');

  
const botResponses = {
    
  
     
    'hello': 'Hello! How can I assist you today?',
    'hi': 'Hi there! How can I help?',
    'bye': 'Goodbye! Have a great day!',
    'thanks': 'You\'re welcome!',
    'how many days to return a product?': 'Within three days!',
    'help': 'How can I help you?',
    'what is your name?': 'I am Shash!',
    'what voice recogniser available?': 'No!',
    'how are you?': 'I am just a chatbot, but I hope you are doing well!',
    'what do you do?': 'I can chat with you, answer your questions, and help you with various tasks.',
    'tell me a joke': 'Why did the chicken cross the road? To get to the other side!',
    'what time is it?': 'Sorry, I can\'t tell the time, but you can check your device\'s clock!',
    'weather': 'I can\'t check the weather, but you can use a weather app to find out!',
    'tell me about yourself': 'I am Shash, your friendly chatbot!',
    'what is your favorite color?': 'I like all colors, but I don\'t have a personal preference!',
    'what is the meaning of life?': 'That is a complex question! Some say it is to find happiness and purpose.',
    'how old are you?': 'I am a chatbot, so I do not have an age!',
    'who made you?': 'I was created by Harihares!',
    'what is your favorite movie?': 'I don\'t watch movies, but I hear a lot of people like The Matrix!',
    'what is your favorite book?': 'I enjoy all kinds of books, but I cannot read them myself!',
    'what are the key goals of your app?': 'Selling both machinery and agri products!', 
    'how to find the payment options?' : 'You can find the payment option after you ordered the product!',
    'is international shipping available?': 'No!',
    'is customer service availbale on sundays?': 'Yes!',
    'is international currency accepted?': 'Only indian currency accepted!'
    
    
    
    
    
    
};

function getBotResponse(input) {
   
    const userInput = input.toLowerCase();
    
  
    if (botResponses.hasOwnProperty(userInput)) {
        return botResponses[userInput];
    } else {
        return 'I\'m not sure how to respond to that, but I\'m here to chat!';
    }
}


    
    function addMessage(message, sender = 'user') {
        const messageElement = document.createElement('div');
        messageElement.className = sender === 'user' ? 'chatbot-message user' : 'chatbot-message bot';
        messageElement.innerText = message;
        chatbotMessages.appendChild(messageElement);
        chatbotMessages.scrollTop = chatbotMessages.scrollHeight;
    }

    
    function handleSendMessage() {
        const userMessage = chatbotInput.value.trim().toLowerCase();
        if (userMessage) {
            addMessage(userMessage, 'user');
            chatbotInput.value = '';

            // Determine bot response based on user message
            const botResponse = botResponses[userMessage] || 'Sorry, I don\'t understand.';
            addMessage(botResponse, 'bot');
        }
    }

    
    chatbotSendButton.addEventListener('click', handleSendMessage);

    
    chatbotInput.addEventListener('keyup', function(event) {
        if (event.key === 'Enter') {
            handleSendMessage();
        }
    });
});
