

class JsonStringUtility {
    convertStringToJson = (str)=>{
        return JSON.parse(str)
    }

    convertJsonToString = (jsonObj) => {
        return JSON.stringify(jsonObj);
    }
}

module.exports = new JsonStringUtility();