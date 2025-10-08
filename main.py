import vk_api
import pandas as pd
from datetime import datetime
import time
import os
from dotenv import load_dotenv

load_dotenv()

VK_TOKEN = os.getenv("VK_TOKEN")
PAGE_ID = 'eeoneguy'
POST_COUNT = 100

vk_session = vk_api.VkApi(token=VK_TOKEN)
vk = vk_session.get_api()

all_posts_data = []
offset = 0
print(f"Начинаем сбор постов со страницы: {PAGE_ID}")

while len(all_posts_data) < POST_COUNT:
    try:
        wall = vk.wall.get(domain=PAGE_ID, count=100, offset=offset)
        
        if not wall['items']:
            break
        for post in wall['items']:
            post_data = {
                'post_id': post['id'],
                'date': datetime.fromtimestamp(post['date']).strftime('%Y-%m-%d %H:%M:%S'),
                'likes': post['likes']['count']
            }
            all_posts_data.append(post_data)

        offset += 100
        print(f"Собрано {len(all_posts_data)} постов")
        time.sleep(0.4)

    except vk_api.ApiError as e:
        print(f"Ошибка API: {e}")
        break

print("Сбор данных завершен.")

df = pd.DataFrame(all_posts_data)
df['date'] = pd.to_datetime(df['date'])
df = df.sort_values(by='date').reset_index(drop=True)
df['interval_hours'] = df['date'].diff().dt.total_seconds() / 3600
df['interval_hours'].fillna(0, inplace=True)
df.to_csv('posts.csv', index=False)

print("Данные успешно сохранены в файл posts.csv")