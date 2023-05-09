import requests
import os
import sqlite3
from bs4 import BeautifulSoup
import time
import os


# Check first time and if it has more results
first_time = True
no_results = False

# Variables
type_estate = {'apartamentos', 'moradias'}
type_selling = {'comprar', 'alugar'}

# Establish connection to database
conn = sqlite3.connect('houses.sqlite3')
c = conn.cursor()

# Create table if it doesn't exist
c.execute('''CREATE TABLE IF NOT EXISTS houses
             (link text, type text, selling_type text)''')

for x in type_estate:
    for y in type_selling:

        no_results = False
        number_page = 1
        num_real_state_category = 0

        while no_results == False:
            url = 'https://casa.sapo.pt/' + y + '-' + x + '/?pn=' + str(number_page)
            headers = {
                'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'}

            print(url)
            page = requests.get(url, headers=headers)

            print(f"[[STATUS] | {str(page.status_code)}] || [{url}]\n\
                  progress : {x}:{y} : {num_real_state_category}\n\
                  pages : {number_page}\n\
                  ", end="\r", flush=True)

            while page.status_code != 200:
                time.sleep(10)

            soup = BeautifulSoup(page.content, "html.parser")

            apartments = soup.find_all("div", class_="property-info-content")

            num_apartments = len(apartments)
            num_real_state_category+=num_apartments

            for apartment in apartments:
                link = apartment.find("a", class_="property-info")["href"]

                if link[0] == '/':
                    link = 'https://casa.sapo.pt' + link
                else:
                    link = link[109:]

                # Insert scraped data into database
                c.execute("INSERT INTO houses VALUES (?, ?, ?)", (link, x, y))

            number_page += 1

            if num_apartments == 0:
                no_results = True

# Commit changes to database and close connection
conn.commit()
conn.close()