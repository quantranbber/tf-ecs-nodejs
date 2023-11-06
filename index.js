const express = require('express');
const { S3, AWS } = require('aws-sdk');
const app = express();
const port = 3000;
const s3 = new S3({
    region: 'ap-southeast-1'
});

app.get('/health', async (req, res) => {
    res.send('success');
});

app.get('/', async (req, res) => {
    console.log('zzzzzzzzzzz');
    try {
        const params = {
            Bucket: 'quan-test-bk',
            Prefix: 'test',
        };
        const obj = await s3.listObjectsV2(params).promise();
        res.send({
            obj
        });
    } catch (err) {
        res.send({
            error: err
        });
    }
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
