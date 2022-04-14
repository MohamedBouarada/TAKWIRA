import axios from "axios"

axios.defaults.baseURL = "http://localhost:5000" ;




export const getAllUsers =  async (orderBy="id",sort="ASC",perPage=5,page=1)=>{

    try{
        const response = await axios({
            method : "GET",
            url :`/admin/users/all?sort=${sort}&order=${orderBy}&perPage=${perPage}&page=${page}`,

        })
        return {success:true , data : response.data}
    }catch (e) {
        console.log(e)
        return {success:false , data : e.response.data}
    }

}