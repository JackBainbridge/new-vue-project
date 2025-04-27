import axios from "axios";

const API_URL = "http://localhost:3001"; // Replace with your actual API URL
const EMAIL_API_URL = `${API_URL}/email`;

const sendEmail = async (emailData) => {
    try {
        const endpoint = `${EMAIL_API_URL}/send`;
        const response = await axios.post(endpoint, emailData);
        return response;

    } catch (error) {
        console.error("Error sending email:", error);
        throw error;
    }    
}

export default {
    sendEmail
}