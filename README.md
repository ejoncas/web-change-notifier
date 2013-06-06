<h2>Web Change Notifier</h2>

<p>Script useful for detecting change in websites.</p>

<p>
Install it with a crontab expression:
</p>
<pre><code>
#Check for changes every hour
0 * * * * /path/to/project/web-change-notifier/check.sh >> /path/to/project/web-change-notifier/run.log
</code></pre>
