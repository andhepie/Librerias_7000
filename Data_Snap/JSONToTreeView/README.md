# JSONToTreeView

Esta libreria toma un `ss: string` que proviene de un JSON y lo escribe en un componente TTreeView.

## ¿Cómo Usarlo?

1. Crear una variable `JSONToTreeView: TJSONToTreeView`
2. Inicializar la variable `JSONToTreeView := TJSONToTreeView.Create;`
3. Asignarle un TTreeView que este en el formulario (Suponiendo que tengamos un tvArbol: TTreeView), se hace `JSONToTreeView.TreeView := tvArbol`
4. Se envia la cadena a convertir `JSONToTreeView.generarArbol(ss: string)`