sleep 5
curl -X POST http://connector:8083/connectors \
			-H "Content-Type: application/json" \
			--data "
			{
                \"name\":\"s3_sink\",
                \"config\":{
                    \"connector.class\":\"io.confluent.connect.s3.S3SinkConnector\",
                    \"topics\":\"my-topic\",
                    \"s3.region\":\"us-east-1\",
                    \"s3.bucket.name\":\"my-bucket\",
                    \"tasks.max\":\"1\",
                    \"flush.size\":\"1\",
                    \"s3.endpoint\":\"http://minio:9000\",
                    \"format.class\": \"io.confluent.connect.s3.format.json.JsonFormat\",
                    \"storage.class\": \"io.confluent.connect.s3.storage.S3Storage\",
                    \"key.converter\": \"org.apache.kafka.connect.json.JsonConverter\",
                    \"value.converter\":\"org.apache.kafka.connect.converters.ByteArrayConverter\",
                    \"partitioner.class\":\"io.confluent.connect.storage.partitioner.TimeBasedPartitioner\",                                                                                                                                                                                                                                                                                                                                                                                                      
                    \"locale\":\"en\",
                    \"timezone\":\"UTC\"     
                }
            }"