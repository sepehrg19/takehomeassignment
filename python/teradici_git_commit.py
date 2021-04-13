import requests
import datetime


# the original URL is https://github.com/teradici/deploy, I used the github rest api information page to identify what the api URL is
url = "https://api.github.com/repos/teradici/deploy/commits"

# get the list of users and put it into json format
user_data = requests.get(url).json()

# print the author
print('The author of https://github.com/teradici/deploy is: ' + user_data[0]['author']['login'])

# get the total commits where the author is not none
total_commits = [commit for commit in user_data if commit['author'] is not None ]

# grab the list of committers
mapper = {}
for commit in total_commits:
    committer_list = commit['commit']['author']['name'] 
    if committer_list in list(mapper.keys()):
        mapper[committer_list] = mapper[committer_list] + 1
    else:
        mapper[committer_list] = 1

# from the list committers, get the committer with most commits 
top_committer = max(mapper, key=mapper.get)

# print the top committer
print('The top committer of all time is: ' + top_committer)

# specify the start and end dates
matched = []
start_date = datetime.datetime(year=2020, month=7, day=1, tzinfo=datetime.timezone.utc)
end_date =  datetime.datetime(year=2020, month=8, day=30,tzinfo=datetime.timezone.utc)
print('Here are the commits between the specified dates:')

# search the specified dates and print the date for every commit
total_commits = [commit for commit in user_data if commit['author'] is not None ]
for commit in total_commits:
    dateString = commit['commit']['author']['date']
    date_time_object = datetime.datetime.strptime(dateString, '%Y-%m-%dT%H:%M:%S%z')
    if date_time_object >= start_date and date_time_object <= end_date:
        print(date_time_object)