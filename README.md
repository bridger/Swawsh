# Swawsh

A cross platform library for signing AWS Signature Version 4 requests written in Swift.

http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html

### Example Usage (macOS)
```swift
let swawsh = Swawsh.sharedInstance
if let authorization = swawsh.generateCredential(
    method: .GET,
    path: "/",
    endPoint: "ec2.amazonaws.com",
    queryParameters: "Action=DescribeRegions&Version=2013-10-15",
    payloadDigest: Swawsh.emptyStringHash,
    region: "us-east-1",
    service: "ec2",
    accessKeyId: accessKeyId,
    secretKey: secretAccessKey
    )
{
    let url = URL(string: "https://ec2.amazonaws.com/?Action=DescribeRegions&Version=2013-10-15")
    var request = URLRequest(url: url!)
    request.addValue(authorization, forHTTPHeaderField: "Authorization")
    request.addValue(swawsh.getDate(), forHTTPHeaderField: "x-amz-date")
    request.addValue(Swawsh.emptyStringHash, forHTTPHeaderField:"x-amz-content-sha256")
    request.addValue("ec2.amazonaws.com", forHTTPHeaderField: "Host")
    request.httpMethod = "GET"

    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print(responseString)
    }
    task.resume()
}
```