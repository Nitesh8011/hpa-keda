# KEDA Scaling Metrics

KEDA (Kubernetes Event-Driven Autoscaling) allows Kubernetes workloads to scale based on external metrics beyond just CPU and memory. It integrates with various **scalers** to enable event-driven scaling.

## Available Metrics and Scalers in KEDA

KEDA supports a variety of **built-in scalers**, each corresponding to an external system. Below is a list of supported scalers along with examples of how to configure them.

### 1. **RabbitMQ Queue** (Scale based on messages in a queue)
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: rabbitmq-scaledobject
spec:
  scaleTargetRef:
    name: my-rmq-consumer
  minReplicaCount: 1
  maxReplicaCount: 10
  triggers:
    - type: rabbitmq
      metadata:
        queueName: my-queue
        hostFromEnv: RABBITMQ_HOST
        mode: QueueLength
        value: '100'
```

---

### 2. **HTTP Requests** (Scale based on request rate)
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: http-scaledobject
spec:
  scaleTargetRef:
    name: my-web-app
  minReplicaCount: 1
  maxReplicaCount: 10
  triggers:
    - type: prometheus
      metadata:
        serverAddress: http://prometheus-server.monitoring:9090
        query: sum(rate(http_requests_total{job="my-app"}[1m]))
        threshold: '100'
```

---

### 3. **CPU Usage** (Scale based on CPU utilization)
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: cpu-scaledobject
spec:
  scaleTargetRef:
    name: my-deployment
  minReplicaCount: 1
  maxReplicaCount: 10
  triggers:
    - type: cpu
      metadata:
        type: Utilization
        value: "75"
```

---

### 4. **Memory Usage** (Scale based on Memory utilization)
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: memory-scaledobject
spec:
  scaleTargetRef:
    name: my-deployment
  minReplicaCount: 1
  maxReplicaCount: 10
  triggers:
    - type: memory
      metadata:
        type: Utilization
        value: "80"
```

---

### 5. **PostgreSQL Database Connection** (Scale based on active connections)
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: postgres-scaledobject
spec:
  scaleTargetRef:
    name: my-postgres-app
  minReplicaCount: 1
  maxReplicaCount: 10
  triggers:
    - type: postgresql
      metadata:
        connectionFromEnv: POSTGRES_CONN
        query: "SELECT COUNT(*) FROM pg_stat_activity WHERE state='active'"
        threshold: "50"
```

---

### 6. **Cron-based Scheduling** (Scale up/down based on time schedule)
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: cron-scaledobject
spec:
  scaleTargetRef:
    name: my-deployment
  minReplicaCount: 1
  maxReplicaCount: 5
  triggers:
    - type: cron
      metadata:
        timezone: UTC
        start: 0 9 * * *  # Scale up at 9 AM UTC
        end: 0 17 * * *   # Scale down at 5 PM UTC
        desiredReplicaCount: '5'
```

---

## **Conclusion**

KEDA provides a powerful way to scale Kubernetes workloads based on external event sources. This allows for **event-driven autoscaling** beyond traditional CPU/memory-based scaling. By leveraging built-in scalers or creating custom ones, you can scale your applications efficiently and cost-effectively.

For more details, check the official [KEDA documentation](https://keda.sh/docs/latest/scalers/).