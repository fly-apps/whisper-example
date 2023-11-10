import whisper

model = whisper.load_model("large")

result = model.transcribe("audio.mp3")

print(result["text"])
print(result["segments"])

