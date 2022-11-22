# Actividad 1
## Javier Esmerado Vela

```{r setup, include=FALSE}
# UI
library(shiny)
library(shinydashboard)
library(plotly)
library(cowplot)
library(dplyr)
```

## Shiny Server & UI

```{r}
# Import data
trumpData <- read.csv("./data/TRUMPWORLD-pres.csv")
```

### **El año con mayor confianza**

En nuestra variable `year_with_max_confident` vamos a almacenar el año con el máximo `avg`.

```{r}
year_with_max_confident <- trumpData$year[which.max(trumpData$avg)]

renderValueBox({
    valueBox(year_with_max_confident, "Most Confident Year")
  })

```

### **The country with the highest average confidente data**

Creamos la función `most_confident_country`, lo primeros que haremos será eliminar las dos columnas que no vamos a necesitar para este apartado (`avg`, `year`), una vez lo tenemos, con la función `colMeans`, obtenemos las medias de cada columna, utilizado la propiedad de na.rm = T, para eliminar todas las celdas vacías. Una vez tenemos esto, con la función `colnames`, obtenemos el elemento con mayor media.

```{r}
most_confident_country <- function() {
  trumpDeleted <- select(trumpData, -avg, -year)
  medianData <- colMeans(trumpDeleted, na.rm = T,  dims = 1)
  mcc <-colnames(trumpDeleted[which.max(medianData)])
  return(mcc)
}

renderValueBox({
    valueBox(most_confident_country(), "Most Confident Country")
  })
```

### **Diagrama de barras con el valor medio de confianza por año**

Creamos una variable para tener un código más legible y limpio. Utilizamos la función `plot_ly`, definimos los datos y el tipo de gráfica. Con `add_trace`, definimos los datos de `x` e `y`. Por último le damos estilos.

```{r}
firstGraph <-  plot_ly(trumpData, type = 'bar') %>%
  add_trace(x = ~year, y = ~avg) %>%
  layout(plot_bgcolor='#e5ecf6', 
         xaxis = list( 
           showlegend = F,
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff'), 
         yaxis = list( 
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff'))

renderPlotly({firstGraph})
```

### **Diagrama de línea con la evolución de la opinión en España**

Utilizamos la función `plot_ly`, definimos los datos y el tipo de gráfica. Con `add_trace`, definimos los datos de `x` e `y`. Damos estilos.

```{r}
secondGraph <- plot_ly(trumpData, type = 'scatter', mode = 'lines')%>%
  add_trace(x = ~year, y = ~Spain) %>%
  layout(showlegend = F,  
         xaxis = list(
           zerolinecolor = '#ffff',
           zerolinewidth = 2,
           gridcolor = 'ffff'),
         yaxis = list(
           zerolinecolor = '#ffff',
           zerolinewidth = 2,
           gridcolor = 'ffff'),
         plot_bgcolor='#e5ecf6')

renderPlotly({secondGraph})
```
