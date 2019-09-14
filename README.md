# bhukkd 
> A spicy hot place to find food that lets you book a table in nearby restaurants.

## Application detail
This application is developed on **flutter v1.10.2** for android and ios platform. You can get details about all the restaurants near your location. Moreover this application is modeled for booking the tables in the restaurants.

## Database
Firebase cloud-storage is used as the database source. and the data is originally from Zomato API.

## Instructions
1. Clone the repository.
2. Create a project on firebase and get "google-services.json" file from <a href="https://console.firebase.google.com/" width="250">  console.firebase.google</a>.
3. Paste the "google-services.json" file in "bhukkd\android\app\".
4. Get the Zomato API key from <a href="https://developers.zomato.com/api" width="250">developers.zomato</a>
5. Get the Leaflet API key from <a href="https://account.mapbox.com" width="250">mapbox</a>.
6. Create a "config.json" file in "bhukkd\assets\api\" and paste
<pre>
{
  "api_key": "YOUR_ZOMATO_API_KEY",
  "map_api_key": "YOUR_LEAFLET_API_KEY",
}
</pre>
7. Run the command using "flutter run" to install and run the application on your phone.
  

## ScreenShorts:
<p float="left">
  <a href="https://imgur.com/Mw28Pwg.jpg"><img src="https://imgur.com/Mw28Pwg.jpg" width="50"></a>
<p><b>Appicon</b></p>
  
<a href="https://imgur.com/HCjFdaJ.jpg" width="250"></a>
<a href="https://imgur.com/mEZhK1u.jpg"><img src="https://imgur.com/mEZhK1u.jpg" width="250"></a>
<a href="https://imgur.com/8VyUrSz.jpg"><img src="https://imgur.com/8VyUrSz.jpg" width="250"></a>
<a href="https://imgur.com/FvNqfKU.jpg"><img src="https://imgur.com/FvNqfKU.jpg" width="250"></a>
<a href="https://imgur.com/qT65auw.jpg"><img src="https://imgur.com/qT65auw.jpg" width="250"></a>
<a href="https://imgur.com/KA6Ne3g.jpg"><img src="https://imgur.com/KA6Ne3g.jpg" width="250"></a>
<a href="https://imgur.com/8nHHNkj.jpg"><img src="https://imgur.com/8nHHNkj.jpg" width="250"></a>
<a href="https://imgur.com/77z8SmG.jpg"><img src="https://imgur.com/77z8SmG.jpg" width="250"></a>
<a href="https://imgur.com/devAatO.jpg"><img src="https://imgur.com/devAatO.jpg" width="250"></a>
<a href="https://imgur.com/aBQs1GL.jpg"><img src="https://imgur.com/aBQs1GL.jpg" width="250"></a>
</p>

## Support:
https://flutter.dev/docs
<br>
https://firebase.google.com/support/
<br>
https://developers.zomato.com/contact
<br>
https://docs.mapbox.com/help/

## License:
Copyright 2019 Google, Inc. Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements. See the NOTICE file distributed with this work for additional information regarding copyright ownership. The ASF licenses this file to you under the Apache License, Version 2.0 (the “License”); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
