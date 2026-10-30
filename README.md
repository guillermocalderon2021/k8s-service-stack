# DevOps Kubernetes · Entorno local

Repositorio de apoyo para las prácticas de Kubernetes con **k3d**. Contiene una API Express, PostgreSQL y manifiestos de Kubernetes. La explicación de conceptos, las actividades, los comandos de inspección y los resultados esperados se encuentran en el **material de clase**, no en este repositorio.

## Requisitos

- Docker Engine en ejecución, k3d, kubectl, Bash, OpenSSL y curl.
- Conexión a Internet para descargar las imágenes iniciales.
- Puerto `8081` libre en la interfaz local; se puede modificar mediante `HTTP_PORT` al crear el clúster y ejecutar las verificaciones.

## Archivos

- `app/`: código de la API, Dockerfile y pruebas automatizadas.
- `k8s/`: configuración declarativa del entorno de demostración.
- `scripts/`: utilidades para crear el entorno, desplegar, verificar y limpiar.
- `plantillas/`: ejercicios de edición de manifiestos; **no se aplican automáticamente**.

## Preparación inicial

Desde la raíz del repositorio, en una terminal Bash:

```bash
bash scripts/create-cluster.sh
bash scripts/build-import.sh
bash scripts/deploy.sh
bash scripts/verify.sh
```

Para ejecutar las pruebas de Node.js en el equipo local:

```bash
cd app
npm install
npm test
```

La API local está disponible en `http://127.0.0.1:8081`. El clúster se llama `devops-local` y el namespace utilizado es `devops-demo`.

## Uso y precauciones

Los manifiestos en `k8s/` constituyen un **entorno de partida ejecutable**, que se modificará durante las actividades. Los ejemplos de `plantillas/` se completan cuando lo indique el material de clase, sin sustituir directamente los manifiestos funcionales hasta comprobarlos.

`create-secret.sh` genera una contraseña ficticia fuera del repositorio. No versionar Secrets reales, archivos `.env`, kubeconfigs ni credenciales. El entorno de ejemplo escucha solo en localhost mediante HTTP y utiliza almacenamiento local de k3d; no es una configuración de producción ni proporciona alta disponibilidad.

Para detener y reanudar el clúster:

```bash
k3d cluster stop devops-local
k3d cluster start devops-local
```

Para eliminarlo **incluyendo sus datos locales**:

```bash
bash scripts/cleanup.sh
```

**Referencias:** [Kubernetes](https://kubernetes.io/docs/), [K3s](https://docs.k3s.io/), [k3d](https://k3d.io/).
