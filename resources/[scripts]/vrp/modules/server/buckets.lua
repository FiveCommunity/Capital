local bucketIDS = Tools.newIDGenerator()

function vRP.genBucket()
    return bucketIDS:gen()+1
end

function vRP.freeBucket(id)
    return bucketIDS:free(id-1)
end