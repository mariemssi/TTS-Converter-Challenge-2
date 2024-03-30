# TTS Converter App - Challenge 2 - GitHub actions workflows
![image](https://github.com/mariemssi/TTS-Converter-Challenge-2/assets/69463864/036a72b8-a398-487c-b06a-e0d862c9fad0)



The second challenge involves creating GitHub Actions workflows to automate the deployment of infrastructure and Lambda code changes. To solve it, two pipelines are created: lambda pipeline and TTS Converter App Infra pipeline

# Steps to run the solution of challenge 2 

1. Clone the project
   
2. Create an S3 bucket for the remote backend and update the name of the bucket in "terraform-config.tf"
   
3. Create a versioned S3 bucket for uploading zipped Lambda files (Artifact of lambda pipeline)

   The Lambda pipeline needs to share the zip file with the TTS Converter App Infra pipeline, and I choose to do it via an S3 bucket. As a remark, I tried using the GitHub Action "actions/download-artifact@v4". It works 
   well for sharing data between jobs within the same workflow but doesn't work for different workflows.
   
   Enabling versioning on this bucket assigns a unique version ID to each uploaded file version. This versioning mechanism ensures that every update to the Lambda code 
   triggers a redeployment of the Lambda function.

   
  5. Update the bucket name and object key in "lambda.tf" and aws-bucket in the step "Upload to S3" in "code.yaml" by the bucket created in step 3
   
6. Set your AWS credentials (access key and secret access key) as environment secrets in your github repo with the names "AWS_ACCESS_KEY_ID" and "AWS_SECRET_ACCESS_KEY"

   ![image](https://github.com/mariemssi/TTS-Converter-Challenge-2/assets/69463864/f0029d84-0d2d-4df2-bc20-f4d2d1e4656e)


   
6. Test "lambda pipeline" by adding a comment in the lambda code and push it - verify that you have a zipped file in the bucket that you created in step 3

   ![image](https://github.com/mariemssi/TTS-Converter-Challenge-2/assets/69463864/e0336af1-2b91-4673-9f96-ac39bd11e38d)

   
8. After a successful run of the "lambda pipeline," the TTS Converter App Infra pipeline will be triggered automatically. However, the deployment of resources requires 
   manual triggering by selecting the "Apply" input option in the TTS Converter App Infra pipeline. This manual trigger was chosen to allow for manual control over apply 
   and destroy actions.

   ![image](https://github.com/mariemssi/TTS-Converter-Challenge-2/assets/69463864/b270f296-d296-4eb5-aa1a-08aabbdcdca3)
 




   
10. Verify that the app running correctly in AWS
   
      Try the app using a curl query using the invokeURL of the API Gateway stage, which you can obtain from the output of the Terraform code or directly from the AWS 
      Management Console (you can use the example in [this link](https://medium.com/@lucas.ludicsa99/texttospeechconvertertext-to-speech-converter-using-aws-lambda-polly-and-api-gateway-bf814d2bbe84)) 
   

11. Make a change in the Terraform code and push it to your repository to automatically trigger the TTS Converter App Infra pipeline. You'll need to trigger the apply of 
    your changes by selecting the "Apply" option in the TTS Converter App Infra pipeline.
   
12. Once testing is complete, select the "Destroy" option in the TTS Converter App Infra pipeline to tear down the resources.


You can find more details [here](https://medium.com/@meriemiag/text-to-speech-converter-challenge2-github-actions-workflows-16c59556e6c1) 
