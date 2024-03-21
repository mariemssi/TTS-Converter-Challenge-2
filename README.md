# Architecture of TTS Converter App (A simple AWS app to transform a text to speech)
![image](https://github.com/mariemssi/TTS-Converter-Challenge-1/assets/69463864/fd77f547-5198-4866-b89a-71d7dcfe7889)


# Steps to deploy the app

1. Clone the project
   
2. Run `terraform init`
   
3. Run `terraform apply`
   
4. Try the app using a curl query using the invokeURL of the API Gateway stage, which you can obtain from the output of the Terraform code or directly from the AWS Management Console (you can use the example in [this article](https://medium.com/@lucas.ludicsa99/texttospeechconvertertext-to-speech-converter-using-aws-lambda-polly-and-api-gateway-bf814d2bbe84) )
   
5. Once you've finished testing, remember to run `terraform destroy` to delete all resources if you no longer need them.

## Remark
You need to provide the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY credentials to allow Terraform to connect and authenticate successfully to AWS. These credentials can be embedded directly into the Terraform code (although this is not considered best practice), 
or you can leverage terminal environment variables or use a shared credentials file in the local file system. 

You can find more details in [article1](https://medium.com/@lucas.ludicsa99/texttospeechconvertertext-to-speech-converter-using-aws-lambda-polly-and-api-gateway-bf814d2bbe84) and [article2](https://medium.com/@meriemiag/text-to-speech-converter-challenge1-ba89607d936b)
