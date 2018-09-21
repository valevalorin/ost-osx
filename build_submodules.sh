
cd ost-hook-actor
npm install
pkg -t latest-macos-x64 -o ../ost-hook-actor.exe ./index.js

cd ../ost-sound-agent
npm install
pkg -t latest-macos-x64 -o ../ost-sound-agent.exe ./app.js 

cd ..