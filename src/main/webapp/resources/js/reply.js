
const getReplyList = async (mbNo, page) => {

    const pageValue = page || 1

    const response = await axios.get(`/replies/list/${mbNo}/${pageValue}`)

    console.log(mbNo)
    console.log(page)

    return response.data

}

async function addReply(reply) {

    const response = await axios.post("/replies", reply)
    return response.data
}

async function addReComment(reply) {

    const response = await axios.post(`/replies/${reply.originReNo}`, reply)
    return response.data
}

const removeReply = async (mbReNo) => {
    const response = await axios.delete(`/replies/${mbReNo}`)
    return response.data
}

const modifyReply = async (reply) => {

    const response = await axios.put(`/replies/${reply.mbReNo}` , reply)

    return response.data
}