const StreamChat = require('stream-chat').StreamChat;

const apiKey = 'fc4gkmh4ykdg';
const apiSecret = 'h3gqj7wm6av5gnvch6zsjgsacesanpkbxvzyufu83d3svfchm3zb7fhajaw4dh8k';

exports.generateToken = function(idUser, doneCallback) {
    const client = new StreamChat(apiKey, apiSecret);
    const token = client.createToken(idUser);


    doneCallback(token);
};