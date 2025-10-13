

"""
Flask szerver a Szótár-Robi webapp kiszolgálásához
"""

from flask import Flask, send_from_directory, send_file
import os
import sys

app = Flask(__name__)


WEBAPP_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'webapp')

@app.route('/')
def index():
    """Főoldal - átirányítás a Szotar-Robi.html-re"""
    return send_file(os.path.join(WEBAPP_DIR, 'Szotar-Robi.html'))

@app.route('/<path:filename>')
def serve_static(filename):
    """Statikus fájlok kiszolgálása a webapp könyvtárból"""
    return send_from_directory(WEBAPP_DIR, filename)

@app.route('/sample_lessons/<path:filename>')
def serve_lessons(filename):
    """Lecke fájlok kiszolgálása"""
    lessons_dir = os.path.join(WEBAPP_DIR, 'sample_lessons')
    return send_from_directory(lessons_dir, filename)

@app.route('/shutdown', methods=['POST'])
def shutdown():
    """Szerver leállítás endpoint"""
    from flask import request
    import threading
    import time
    
    def shutdown_server():
        time.sleep(0.5)  # Rövid várakozás a válasz elküldésére
        print("Szerver leállítás kérve a weboldalról...")
        import os
        import signal
        # Többféle leállítási módszer próbálása
        try:
            os.kill(os.getpid(), signal.SIGTERM)
        except:
            try:
                os._exit(0)
            except:
                import sys
                sys.exit(0)
    
    # Háttérszálon indítjuk a leállítást
    threading.Thread(target=shutdown_server, daemon=True).start()
    return 'Szerver leállítás folyamatban... Zárja be a böngészőt.'

if __name__ == '__main__':
    print(f"Szótár-Robi Flask szerver indítása...")
    print(f"Webapp könyvtár: {WEBAPP_DIR}")
    print(f"Elérhető lesz: http://localhost:5001")
    print("A szerver leállításához nyomja meg a Ctrl+C kombinációt")
    
    # Ellenőrizni, hogy létezik-e a webapp könyvtár
    if not os.path.exists(WEBAPP_DIR):
        print(f"HIBA: Webapp könyvtár nem található: {WEBAPP_DIR}")
        sys.exit(1)
        
    # Ellenőrizni, hogy létezik-e a Szotar-Robi.html
    html_file = os.path.join(WEBAPP_DIR, 'Szotar-Robi.html')
    if not os.path.exists(html_file):
        print(f"HIBA: Szotar-Robi.html nem található: {html_file}")
        sys.exit(1)
        
    app.run(host='0.0.0.0', port=5001, debug=False, use_reloader=False)