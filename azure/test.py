import requests
import time
import statistics

# Definir la URL y los headers
url = "http://10.0.8.4:8080/api/v1/auth/tokens"  # Reemplaza con tu URL
headers = {
    "Content-Type": "application/json"}#/*,
#    "Authorization": "Bearer tu_token"  # Reemplaza con tu token
#}
body = {
    "userName": "AdminMarsella",
    "password": "AdminMarsella"}
# Lista para guardar los tiempos de respuesta
response_times = []

# Función para realizar una petición
def make_request():
    start_time = time.time()
    try:
        response = requests.post(url, headers=headers, json=body)
        elapsed_time = time.time() - start_time
        response_times.append(elapsed_time)
        
        if response.status_code != 200:
            print(f"Error: Status code {response.status_code}")
    except requests.RequestException as e:
        print(f"Request failed: {e}")

# Ejecutar 100 peticiones en paralelo
def run_load_test():
    for i in range(10000):
        make_request()

# Ejecutar el test
start_test_time = time.time()
run_load_test()
total_time = time.time() - start_test_time

# Calcular estadísticas
sorted_times = sorted(response_times)
min_time = min(sorted_times)
max_time = max(sorted_times)
average_time = statistics.mean(sorted_times)
median_time = statistics.median(sorted_times)

# Imprimir resultados
print(f"Total time for 100 requests: {total_time:.2f} seconds")
print("Response times (sorted):", sorted_times)
print(f"Minimum response time: {min_time:.4f} seconds")
print(f"Maximum response time: {max_time:.4f} seconds")
print(f"Average response time: {average_time:.4f} seconds")
print(f"Median response time: {median_time:.4f} seconds")