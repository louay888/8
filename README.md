# SSR
> Super resolution spectral

---

## 📁 Project Structure

```
AndroidStudioProjects/
├── Front_end/       # Flutter mobile app
├── Back_end/        # Django REST API + AI pipeline
└── untitled/        # Android Studio project config
```

---

## ⚙️ Requirements

### Backend
- Python 3.10+
- pip
- virtualenv

### Frontend
- Flutter SDK 3.0+
- Android Studio or VS Code
- Android/iOS device or emulator

---

## 🚀 How to Run

### 1. Clone the repo

```bash
git clone https://github.com/louay888/8.git
cd 8
```

---

### 2. Run the Backend (Django)

```bash
cd Back_end

# Create and activate virtual environment
python -m venv .venv

# On Windows:
.venv\Scripts\activate

# On Mac/Linux:
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Apply migrations
python manage.py migrate

# (Optional) Seed initial data
python manage.py seed_data

# Start the server
python manage.py runserver
```

> Backend will run at: `http://127.0.0.1:8000`

---

### 3. Run the Frontend (Flutter)

```bash
cd Front_end

# Install Flutter dependencies
flutter pub get

# Run on connected device or emulator
flutter run
```

> Make sure your emulator is running or a device is connected.

---

## 🔗 API

The Flutter app connects to the Django backend.  
Make sure the backend is running before launching the app.

If testing on a physical device, update the API base URL in:
```
Front_end/lib/services/api_service.dart
```
Change `localhost` to your machine's local IP address (e.g. `192.168.x.x`).

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Mobile App | Flutter / Dart |
| Backend API | Django REST Framework |
| AI Pipeline | PyTorch, OpenCV, SMP |
| Geospatial | GeoPandas, Rasterio, GDAL |
| Output Formats | GeoJSON, Shapefile, World File |

---

## 👤 Author

- **Student:** Louay Jamli  
- **Supervisor:** Lt Bhenkhlifa Aymen
- **School:** EABA — Formation en Géomatique  
- **Year:** 2025–2026
