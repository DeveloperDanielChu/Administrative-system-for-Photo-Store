const path = require('path')
const fs = require('fs');
//const Cliente = require('../models/Cliente');

/**
 * SesionController
 *
 * @description :: Server-side actions for handling incoming requests.
 * @help        :: See https://sailsjs.com/docs/concepts/actions
 */

module.exports = {

  inicioSesion: async (peticion, respuesta) => {
    respuesta.view('pages/admin/inicio_sesion')
  },

  procesarInicioSesion: async (peticion, respuesta) => {
    let admin = await Admin.findOne({ email: peticion.body.email, contrasena: peticion.body.contrasena })
    if (admin) {
      if(admin.activo==1){
        peticion.session.admin = admin
        peticion.session.cliente = undefined
        peticion.addFlash('mensaje', 'Sesión de admin iniciada')
        return respuesta.redirect("/admin/principal")
      }else{
        peticion.addFlash('mensaje', 'Administrador no autorizado')
        return respuesta.redirect("/admin/inicio-sesion");  
      }
      
    } else {
      peticion.addFlash('mensaje', 'Email o contraseña invalidos')
      return respuesta.redirect("/admin/inicio-sesion");
    }
  },

  principal: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash('mensaje', 'Sesión inválida')
      return respuesta.redirect("/admin/inicio-sesion")
    }
    let fotos = await Foto.find().sort("id")
    respuesta.view('pages/admin/principal', { fotos })
  },



  cerrarSesion: async (peticion, respuesta) => {
    peticion.session.admin = undefined
    peticion.addFlash('mensaje', 'Sesión finalizada')
    return respuesta.redirect("/");
  },

  agregarFoto: async (peticion, respuesta) => {
    respuesta.view('pages/admin/agregar_foto')
  },

  procesarAgregarFoto: async (peticion, respuesta) => {
    let foto = await Foto.create({
      titulo: peticion.body.titulo,
      activa: 1
    }).fetch()
    peticion.file('foto').upload({}, async (error, archivos) => {
      if (archivos && archivos[0]) {
        let upload_path = archivos[0].fd
        let ext = path.extname(upload_path)

        await fs.createReadStream(upload_path).pipe(fs.createWriteStream(path.resolve(sails.config.appPath, `assets/images/fotos/${foto.id}${ext}`)))
        await Foto.update({ id: foto.id }, { contenido: `${foto.id}${ext}` })
        peticion.addFlash('mensaje', 'Foto agregada')
        return respuesta.redirect("/admin/principal")
      }
      peticion.addFlash('mensaje', 'No hay foto seleccionada')
      return respuesta.redirect("/admin/agregar-foto")
    })
  },

  desactivarFoto: async (peticion, respuesta) => {
    await Foto.update({id: peticion.params.fotoId}, {activa: 0})
    peticion.addFlash('mensaje', 'Foto desactivada')
    return respuesta.redirect("/admin/principal")
  },

  activarFoto: async (peticion, respuesta) => {
    await Foto.update({id: peticion.params.fotoId}, {activa: 1})
    peticion.addFlash('mensaje', 'Foto activada')
    return respuesta.redirect("/admin/principal")
  },


  MostrarClientes: async(peticion,respuesta)=>{

    let clientes = await Cliente.find().sort("id")
    respuesta.view('pages/admin/clientes', { clientes })


      },


MostrarAdmins: async(peticion,respuesta)=>{

  let administradores = await Admin.find().sort("id")
  respuesta.view('pages/admin/administradores', { administradores })
    
    
  },


  desactivarAdmin: async (peticion, respuesta) => {
    await Admin.update({id: peticion.params.adminId}, {activo: 0})
    peticion.addFlash('mensaje', 'Administrador desactivado')
    return respuesta.redirect("/admin/administradores")
  },


  activarAdmin: async (peticion, respuesta) => {
    await Admin.update({id: peticion.params.adminId}, {activo: 1})
    peticion.addFlash('mensaje', 'Administrador activado')
    return respuesta.redirect("/admin/administradores")
  },
    

  desactivarCliente: async (peticion, respuesta) => {
    await Cliente.update({id: peticion.params.clienteId}, {activo: 0})
    peticion.addFlash('mensaje', 'Cliente desactivado')
    return respuesta.redirect("/admin/clientes")
  },


  activarCliente: async (peticion, respuesta) => {
    await Cliente.update({id: peticion.params.clienteId}, {activo: 1})
    peticion.addFlash('mensaje', 'Cliente activado')
    return respuesta.redirect("/admin/clientes")
  },

  


  Dashboard: async(peticion,respuesta)=>{

    let TotalFotos = await Foto.count()
    let TotalOrdenes=await Orden.count()
    let TotalAdmins=await Admin.count()
    let TotalClientes=await Cliente.count()
    
    
    respuesta.view('pages/admin/dashboard',{TotalFotos,TotalOrdenes,TotalAdmins,TotalClientes})


  },

  ordenes: async (peticion, respuesta) => {
    
    let ordenes = await Orden.find({ cliente: peticion.params.clienteId }).sort('id desc')
    respuesta.view('pages/admin/ordenes', { ordenes })
  },


verFotos: async(peticion,respuesta)=>{
  let orden = await Orden.findOne({ id: peticion.params.ordenId }).populate('detalles')
  //console.log(orden);
  orden.detalles = await OrdenDetalle.find({ orden: orden.id }).populate('foto')
  //console.log(orden);
  respuesta.view('pages/admin/fotos', {orden})
},


};

