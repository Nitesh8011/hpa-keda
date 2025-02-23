# KEDA: Kubernetes Event-Driven Autoscaling

**KEDA (Kubernetes Event-Driven Autoscaling)** is a lightweight and flexible component that enables Kubernetes workloads to scale based on external metrics and event sources beyond traditional CPU and memory-based scaling.

## KEDA Architecture

### KEDA consists of several key components:

* **KEDA Operator:** The core component that manages ScaledObjects and ScaledJobs, ensuring autoscaling logic is applied correctly.

* **KEDA Metrics Server:** Implements Kubernetes’ external metrics API, allowing HPA (Horizontal Pod Autoscaler) to fetch custom metrics.

    ![KEDA Architecture](https://www.redhat.com/rhdc/managed-files/ohc/Custom%20Metrics%20Autoscaler%20on%20OpenShift-3.png)

**Scalers:** Plugins that connect to external event sources and provide scaling metrics.

**Triggers:** Define what conditions should trigger scaling events, based on metrics like queue length, HTTP request rate, or database connections.

**ScaledObject:** A CRD (Custom Resource Definition) that defines the target workload and trigger conditions for scaling.

**ScaledJob:** Similar to ScaledObject but specifically designed for batch jobs.

## How KEDA Works

* KEDA monitors external data sources (like message queues, databases, HTTP traffic, etc.).

* When a defined threshold is met, KEDA feeds the custom metric to Kubernetes’ HPA.

* HPA increases or decreases the number of replicas based on the metric.

* When the workload demand decreases, KEDA can scale down to zero pods to save resources.