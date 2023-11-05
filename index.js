const express = require('express');
const { S3, AWS } = require('aws-sdk');
const app = express();
const port = 3000;
const s3 = new S3({
    region: 'ap-southeast-1'
});

app.get('/', async (req, res) => {
    console.log('zzzzzzzzzzz');
    const params = {
        Bucket: 'agw-quantv-ws',
        Prefix: 'backend/mobile-order-store/dev',
    };
    const obj = await s3.listObjectsV2(params).promise();
    res.send({
        obj
    });
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
