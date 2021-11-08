# Activar / Desactivar

1. Modificar la tabla para agregar la columna activa y un campo acciones para colocar un botón de `activar` o `desactivar`

```HTML
...
          <th>activa</th>
          <th>acción</th>
...

...
            <td><%=foto.activa ? "Si" : "No"%></td>
            <td>
              <% if (foto.activa) { %>
              <a href="/admin/desactivar-foto/<%=foto.id%>" class="btn btn-info">Desactivar Foto</a>
              <% } else { %>
              <a href="/admin/activar-foto/<%=foto.id%>" class="btn btn-primary">Activar Foto</a>
              <% } %>
            </td>
...

```

2. Luego creamos las rutas

```Javascript
'GET /admin/desactivar-foto/:fotoId': 'AdminController.desactivarFoto',

'GET /admin/activar-foto/:fotoId': 'AdminController.activarFoto',
```


3. Finalmente, se agregan los `actions`

```Javascript
  desactivarFoto: async (peticion, respuesta) => {
    await Foto.update({id: peticion.params.fotoId}, {activa: false})
    peticion.addFlash('mensaje', 'Foto desactivada')
    return respuesta.redirect("/admin/principal")
  },

  activarFoto: async (peticion, respuesta) => {
    await Foto.update({id: peticion.params.fotoId}, {activa: true})
    peticion.addFlash('mensaje', 'Foto activada')
    return respuesta.redirect("/admin/principal")
  },
```
