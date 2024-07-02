from datetime import datetime, timedelta, date
import sys
print(f"Starting process at: {datetime.today()}")

print(sys.argv[1])
print(sys.argv[2])

fecha_cad1 = sys.argv[1]
fecha_cad2 = sys.argv[2]
fecha1 = datetime.strptime(fecha_cad1, '%Y-%m-%dT%H:%M:%S')
fecha2 = datetime.strptime(fecha_cad2, '%Y-%m-%dT%H:%M:%S')

dias = (fecha2 - fecha1) / timedelta(days=1)
print(dias)  # 0.041666666666666664



print((fecha2 - fecha1).days)

days= (fecha2 - fecha1).days

for day in range(0,days):
    fecha1 = fecha1 + timedelta(days=1)
    print(fecha1)
