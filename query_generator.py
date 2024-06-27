import requests
import random
import threading
import time
import string
import json


def random_url(n=30):
    return ''.join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=n))

def run(target):
    while True:
        try:
            url = json.dumps({'uri': random_url()})
            headers = {
                        'Content-Type': 'application/json'
                      }
            out = requests.post(url=target, headers=headers, data=url)
            print(out)
        except requests.RequestException as e:
            print(e)
            print("cannot connect", target)
            time.sleep(1)

if __name__ == '__main__':
    urls = ['http://10.96.115.33/mirroring-url-app']
    endpoint = '/query'

    endpoints = [url+endpoint for url in urls]
    threads = []

    for endp in endpoints:
        print(len(endp))
        for i in range(10):
            threads.append(threading.Thread(target=run, args=(endp,)))

    [t.start() for t in threads]
    print("All threads started")

    

