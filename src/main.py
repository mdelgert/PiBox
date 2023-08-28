import datetime
import requests

# Get the current date and time
current_time = datetime.datetime.now()

# Print version
print("Version: 1.0")

# Print the current time
print("Current time:", current_time.time())

# URL to make a GET request to
url = "https://jsonplaceholder.typicode.com/posts/1"

# Make the GET request
response = requests.get(url)

# Check if the request was successful (status code 200)
if response.status_code == 200:
    data = response.json()  # Parse response JSON data
    print("Response JSON:")
    print(data)
else:
    print("Request failed with status code:", response.status_code)