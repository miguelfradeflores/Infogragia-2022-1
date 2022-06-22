import matplotlib.pyplot as plt
from joypy import joyplot
import pandas as pd


read_file = "netflix_titles.csv"
cols = ['type', 'release_year', 'country', 'duration', 'listed_in']

df = pd.read_csv(read_file, usecols=cols)
df.head()

us = df.query("country == 'United States'")
us = us.drop('country', axis=1)



# plt.figure()

df.plot(y='country', x='release_year')

# joyplot(
#     data=us[['type', 'release_year']],
#     by='release_year',
#     figure=(12, 8)
# )

# plt.title("Netflix releases in US")
# plt.show()
