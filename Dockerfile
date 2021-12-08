FROM nginx
EXPOSE 80
RUN   echo "<INSERT_HERE>" >> /tmp/random-string.txt
COPY public/ /usr/share/nginx/html
