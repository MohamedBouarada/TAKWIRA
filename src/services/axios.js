import axios from "axios"

axios.defaults.baseURL = "http://localhost:5000" ;


axios.defaults.headers.common["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZpcnN0QWRtaW5AZ21haWwuY29tIiwidXNlclR5cGUiOiJBRE1JTiIsImlkIjo1LCJpYXQiOjE2NTAyOTc4MzksImV4cCI6MTY1MDU1NzAzOX0.fk_zNQS1MzRBQRvkLnpgAZPmnDPtuTT81VLF9SAiwlc"

export const getAllUsers =  async (orderBy="id",sort="ASC",perPage=5,page=1,searchValue="",role="*")=>{

    try{
        const response = await axios({
            method : "GET",
            url :`/admin/users/filtered?sort=${sort}&order=${orderBy}&perPage=${perPage}&page=${page}&searchValue=${searchValue}&role=${role}`,

        })
        return {success:true , data : response.data}
    }catch (e) {
        console.log(e)
        return {success:false , data : e.response.data}
    }

}

export const getOneUser = async (id)=> {
    try{

        const response = await axios({
            method : "get",
            url : `/admin/users/find/${id}`
        })
            return {success:true,data:response.data}

    }catch (e) {
        console.log(e)
        return {success:false,data:e.response.data}
    }
}

export const addNewUser = async (firstName,lastName,email,password,phoneNumber,role,repeatPassword) =>{
    try{
        const response =  await axios({
            method:"post",
            url:"/user/add",
            data : {firstName,lastName,email,password,phoneNumber,role,repeatPassword}
        })

        return {success: true , data:response.data}
    }catch (e) {
        console.log(e)
        return {success: false , data:e.response.data}
    }
}

export const updateUserGeneralInfos= async (id,email,firstName,lastName,phoneNumber)=>{
    try{
        const response = await axios({
            method:"put",
            url:"/user/updateGeneralInfos",
            data :{id,email,firstName,lastName,phoneNumber}
        })
        return {success: true , data:response.data}
    }catch (e) {
        console.log(e)
        return {success: false , data:e.response.data}
    }
}

export const getAllFields= async (orderBy="id",sort="ASC",perPage=5,page=1,searchValue="",type="*" , surface="*")=>{

    try{
        const response = await axios({
            method : "GET",
            url :`/field/search/all?sort=${sort}&order=${orderBy}&perPage=${perPage}&page=${page}&searchValue=${searchValue}&type=${type}&surface=${surface}`,

        })
        return {success:true , data : response.data}
    }catch (e) {
        console.log(e)
        return {success:false , data : e.response.data}
    }

}


export const getOneField = async (id)=> {
    try{
        const response = await  axios({
            method:"get",
            url : `/field/${id}`
        })

        return {success:true , data : response.data}
    }catch (e) {
console.log(e)
        return {success : false , data:e.response.data}
    }
}

export const activateOwnerRequestAccount = async (id)=> {
    try{
        const response = await axios({
            method: "put",
            url :`/admin/activateAccount/${id}`
        })
        return {success:true , data : response.data}
    }catch (e) {
        console.log(e)
        return {success : false , data:e.response.data}
    }
}