{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nodejs-mongo-persistent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nodejs-mongo-persistent.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nodejs-mongo-persistent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "nodejs-mongo-persistent.labels" -}}
helm.sh/chart: {{ include "nodejs-mongo-persistent.chart" . }}
{{ include "nodejs-mongo-persistent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Backend labels
*/}}
{{- define "nodejs-mongo-persistent.labels.backend" -}}
app.component.type: backend
{{- end -}}

{{/*
Frontend labels
*/}}
{{- define "nodejs-mongo-persistent.labels.frontend" -}}
app.component.type: frontend
{{- end -}}


{{/*
Selector labels
*/}}
{{- define "nodejs-mongo-persistent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nodejs-mongo-persistent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels - backend
*/}}
{{- define "nodejs-mongo-persistent.selectorLabels.backend" -}}
app.component.type: backend
{{- end -}}

{{/*
Selector labels - frontend
*/}}
{{- define "nodejs-mongo-persistent.selectorLabels.frontend" -}}
app.component.type: frontend
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "nodejs-mongo-persistent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "nodejs-mongo-persistent.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
