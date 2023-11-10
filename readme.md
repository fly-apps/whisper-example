# Run Whisper on Fly.io GPU Machines

I used [this article](https://nlpcloud.com/how-to-install-and-deploy-whisper-the-best-open-source-alternative-to-google-speech-to-text.html) for reference.

The easiest way to test this out (if your account [has GPU access](https://community.fly.io/t/fly-gpus-are-here/16110)):

```bash
# 1. Clone the repo
git clone git@github.com:fly-apps/whisper-example.git
cd whisper-example

# 2. Create an app 
fly apps create <some app>

# 3. Edit fly.toml and add your app name there

# 4. Deploy a GPU Machine
#    --vm-gpu-kind a100-pcie-40gb -> Create a a100 GPU machine, 40b memory
#    --volume-initial-size 20     -> create a new volume on create
#    --wait-timeout 600           -> Wait longer for the Machine to start
#    --ha=false                   -> Only create one Machine instance
fly deploy --vm-gpu-kind a100-pcie-40gb \
    --volume-initial-size 20 \
    --wait-timeout 600 --ha=false
```

File `audio.mp3` provided by https://www.flatworldsolutions.com/transcription/samples.php and converted to mp3 via:

```bash
ffmpeg -i Monologue.ogg -b:a 192k audio.mp3
```


