/**
 * pdfReport.js — Genera el reporte PDF del inventario de La Picito
 * Usa jsPDF 3.0.1 + jspdf-autotable 5.0.2
 * Lee los datos directamente desde la base de datos (no localStorage)
 */

import apiEndPoints from './endPoints.js';

const { jsPDF } = window.jspdf;

// Paleta de colores corporativa
const COLOR = {
    primary: [30, 64, 175],   // azul oscuro  #1e40af
    accent: [37, 99, 235],   // azul medio   #2563eb
    lightBlue: [219, 234, 254],  // azul claro   #dbeafe
    amber: [245, 158, 11],   // ámbar        #f59e0b
    dark: [30, 41, 59],   // slate-800
    muted: [100, 116, 139],  // slate-500
    white: [255, 255, 255],
    success: [22, 163, 74],    // verde
};

// Categorías del sistema (id → nombre)
const CATEGORIAS = {
    '1': 'Papelería',
    '2': 'Oficina',
    '3': 'Escolar',
    '4': 'Arte',
    '5': 'Manualidades',
    '6': 'Dibu. Técnico',
    '7': 'Rotulación',
    '8': 'Decoración',
};

// ─────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', function () {

    document.getElementById('PDFReport').addEventListener('click', async () => {
        try {
            // ── 1. Obtener datos de la BD ─────────────────────────────────
            const productos = await apiEndPoints.selectAllProducts();

            if (!productos || productos.errorDB || productos.errorServer) {
                alert('No se pudo obtener los datos de la base de datos.\nVerifica la conexión e intenta de nuevo.');
                return;
            }

            if (productos.length === 0) {
                alert('No hay productos registrados para exportar.');
                return;
            }

            // ── 2. Crear documento ────────────────────────────────────────
            const doc = new jsPDF({
                orientation: 'portrait',
                format: 'letter',
                unit: 'mm',
            });

            const pageW = doc.internal.pageSize.getWidth();   // 215.9 mm
            const pageH = doc.internal.pageSize.getHeight();  // 279.4 mm
            const margenL = 14;
            const margenR = pageW - 14;

            // ── 3. Página 1: encabezado + tabla ───────────────────────────
            const yPostHeader = dibujarEncabezado(doc, pageW, margenL, margenR);
            dibujarTablaProductos(doc, productos, yPostHeader, margenL);

            // ── 4. Página 2: gráfica de barras por categoría ──────────────
            doc.addPage();
            dibujarEncabezado(doc, pageW, margenL, margenR);
            dibujarGraficaCategorias(doc, productos, pageW, pageH, margenL);

            // ── 5. Pie de página en todas las páginas ─────────────────────
            const totalPages = doc.internal.getNumberOfPages();
            for (let i = 1; i <= totalPages; i++) {
                doc.setPage(i);
                dibujarPiePagina(doc, i, totalPages, pageW, pageH, margenL, margenR);
            }

            // ── 6. Guardar ────────────────────────────────────────────────
            const fecha = new Date().toLocaleDateString('es-MX').replace(/\//g, '-');
            doc.save(`LaPicito_Inventario_${fecha}.pdf`);

        } catch (error) {
            console.error('Error al generar el PDF:', error);
            alert('Ocurrió un error al generar el PDF: ' + error.message);
        }
    });

});


// ═══════════════════════════════════════════════════════════
// ENCABEZADO
// ═══════════════════════════════════════════════════════════
function dibujarEncabezado(doc, pageW, margenL, margenR) {

    // Barra superior azul oscuro
    doc.setFillColor(...COLOR.primary);
    doc.rect(0, 0, pageW, 28, 'F');

    // Línea de acento ámbar
    doc.setFillColor(...COLOR.amber);
    doc.rect(0, 28, pageW, 1.5, 'F');

    // Nombre de la empresa
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(18);
    doc.setTextColor(...COLOR.white);
    doc.text('La Picito', margenL, 12);

    // Subtítulo
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(9);
    doc.setTextColor(186, 210, 253); // azul muy claro
    doc.text('Sistema de Gestión de Inventario', margenL, 18);

    // Título del reporte
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(10);
    doc.setTextColor(...COLOR.white);
    doc.text('REPORTE DE INVENTARIO', margenL, 24);

    // Fecha alineada a la derecha
    const fecha = new Date().toLocaleDateString('es-MX', {
        year: 'numeric', month: 'long', day: 'numeric'
    });
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(8);
    doc.setTextColor(186, 210, 253);
    doc.text(`Generado: ${fecha}`, margenR, 24, { align: 'right' });

    return 35; // Y donde empieza el contenido
}


// ═══════════════════════════════════════════════════════════
// TABLA DE PRODUCTOS
// ═══════════════════════════════════════════════════════════
function dibujarTablaProductos(doc, productos, startY, margenL) {

    // Resumen rápido encima de la tabla
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(11);
    doc.setTextColor(...COLOR.dark);
    doc.text('Detalle de productos registrados', margenL, startY);

    doc.setFont('helvetica', 'normal');
    doc.setFontSize(8);
    doc.setTextColor(...COLOR.muted);
    doc.text(`Total de productos: ${productos.length}`, margenL, startY + 5);

    // Preparar datos
    const cuerpo = productos.map((p, index) => [
        index + 1,
        p.codigoBarra ?? '—',
        p.nombre ?? '—',
        '$ ' + parseFloat(p.precio ?? 0).toFixed(2),
        p.existencia ?? '—',
        p.IDmarca ?? '—',
        CATEGORIAS[String(p.IDcategoria)] ?? p.IDcategoria ?? '—',
    ]);

    doc.autoTable({
        startY: startY + 8,
        head: [['#', 'Código', 'Nombre', 'Precio', 'Existencia', 'Marca', 'Categoría']],
        body: cuerpo,
        theme: 'grid',
        headStyles: {
            fillColor: COLOR.primary,
            textColor: COLOR.white,
            fontSize: 9,
            fontStyle: 'bold',
            halign: 'center',
            cellPadding: 3,
        },
        bodyStyles: {
            fontSize: 8,
            textColor: COLOR.dark,
            cellPadding: 2.5,
        },
        alternateRowStyles: {
            fillColor: [241, 245, 249], // slate-100
        },
        columnStyles: {
            0: { halign: 'center', cellWidth: 8 },   // #
            1: { halign: 'center', cellWidth: 22 },   // código
            2: { cellWidth: 'auto' },   // nombre (flexible)
            3: { halign: 'right', cellWidth: 22 },   // precio
            4: { halign: 'center', cellWidth: 20 },   // existencia
            5: { halign: 'center', cellWidth: 18 },   // marca
            6: { halign: 'center', cellWidth: 26 },   // categoría
        },
        margin: { left: 14, right: 14 },
        // Colorear filas con existencia baja (< 10) en rojo suave
        didParseCell: function (data) {
            if (data.section === 'body' && data.column.index === 4) {
                const val = parseInt(data.cell.raw);
                if (!isNaN(val) && val < 10) {
                    data.cell.styles.textColor = [220, 38, 38]; // rojo
                    data.cell.styles.fontStyle = 'bold';
                }
            }
        },
    });
}


// ═══════════════════════════════════════════════════════════
// GRÁFICA DE BARRAS POR CATEGORÍA
// ═══════════════════════════════════════════════════════════
function dibujarGraficaCategorias(doc, productos, pageW, pageH, margenL) {

    const startY = 90;
    const satartYEncabezadoGrafico = 50;

    // Título sección
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(11);
    doc.setTextColor(...COLOR.dark);
    doc.text('Distribución de productos por categoría', margenL, satartYEncabezadoGrafico);

    doc.setFont('helvetica', 'normal');
    doc.setFontSize(8);
    doc.setTextColor(...COLOR.muted);
    doc.text('Cantidad de productos registrados en cada categoría', margenL, startY + 5);

    // Contar productos por categoría (usando nombre legible)
    const conteo = {};
    for (const p of productos) {
        const catNombre = CATEGORIAS[String(p.IDcategoria)] ?? `Cat. ${p.IDcategoria}`;
        conteo[catNombre] = (conteo[catNombre] ?? 0) + 1;
    }

    const categorias = Object.keys(conteo);
    const valores = Object.values(conteo);
    const maxVal = Math.max(...valores);

    // Dimensiones de la gráfica
    const chartX = margenL;
    const chartY = startY + 55;   // base de las barras (eje X)
    const chartW = pageW - 28;    // ancho total
    const maxBarH = 80;            // altura máx de barra en mm
    const gap = 4;             // espacio entre barras
    const n = categorias.length;
    const barW = (chartW - gap * (n - 1)) / n;

    // Colores cíclicos para las barras
    const barColors = [
        COLOR.accent, COLOR.amber, COLOR.success,
        [124, 58, 237], [239, 68, 68], [20, 184, 166],
        [249, 115, 22], [99, 102, 241],
    ];

    // Eje Y: líneas guía horizontales
    doc.setDrawColor(...COLOR.muted);
    doc.setLineWidth(0.2);
    const guias = 5;
    for (let g = 0; g <= guias; g++) {
        const y = chartY - (maxBarH / guias) * g;
        doc.setLineDash([2, 2]);
        doc.line(chartX, y, chartX + chartW, y);
        doc.setLineDash([]);

        // etiqueta del eje Y
        const valGuia = Math.round((maxVal / guias) * g);
        doc.setFontSize(6.5);
        doc.setTextColor(...COLOR.muted);
        doc.text(String(valGuia), chartX - 2, y + 1, { align: 'right' });
    }

    // Dibujar barras
    categorias.forEach((cat, i) => {
        const x = chartX + i * (barW + gap);
        const barH = (valores[i] / maxVal) * maxBarH;
        const y = chartY - barH;
        const color = barColors[i % barColors.length];

        // Sombra suave debajo de la barra
        doc.setFillColor(200, 200, 200);
        doc.roundedRect(x + 1, y + 1, barW, barH, 1.5, 1.5, 'F');

        // Barra principal
        doc.setFillColor(...color);
        doc.roundedRect(x, y, barW, barH, 1.5, 1.5, 'F');

        // Valor encima de la barra
        doc.setFont('helvetica', 'bold');
        doc.setFontSize(7.5);
        doc.setTextColor(...COLOR.dark);
        doc.text(String(valores[i]), x + barW / 2, y - 2, { align: 'center' });

        // Etiqueta de categoría debajo del eje X
        doc.setFont('helvetica', 'normal');
        doc.setFontSize(6.5);
        doc.setTextColor(...COLOR.dark);
        doc.text(cat, x + barW / 2, chartY + 5, { align: 'center', maxWidth: barW + 2 });
    });

    // Línea del eje X
    doc.setDrawColor(...COLOR.dark);
    doc.setLineWidth(0.5);
    doc.line(chartX, chartY, chartX + chartW, chartY);

    // Línea del eje Y
    doc.line(chartX, chartY - maxBarH - 5, chartX, chartY);

    // Leyenda con totales debajo de la gráfica
    const leyendaY = chartY + 22;
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(8);
    doc.setTextColor(...COLOR.dark);
    doc.text('Resumen por categoría:', margenL, leyendaY);

    doc.autoTable({
        startY: leyendaY + 4,
        head: [['Categoría', 'Cantidad de productos', '% del total']],
        body: categorias.map((cat, i) => [
            cat,
            valores[i],
            ((valores[i] / productos.length) * 100).toFixed(1) + ' %',
        ]),
        theme: 'striped',
        headStyles: {
            fillColor: COLOR.primary,
            textColor: COLOR.white,
            fontSize: 8,
            halign: 'center',
        },
        bodyStyles: { fontSize: 8, halign: 'center' },
        columnStyles: { 0: { halign: 'left' } },
        margin: { left: 14, right: 14 },
    });
}


// ═══════════════════════════════════════════════════════════
// PIE DE PÁGINA
// ═══════════════════════════════════════════════════════════
function dibujarPiePagina(doc, pageNum, totalPages, pageW, pageH, margenL, margenR) {

    const y = pageH - 8;

    // Línea separadora
    doc.setDrawColor(...COLOR.primary);
    doc.setLineWidth(0.4);
    doc.line(margenL, y - 3, margenR, y - 3);

    // Texto izquierdo
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(7);
    doc.setTextColor(...COLOR.muted);
    doc.text('La Picito — Sistema de Gestión de Inventario', margenL, y);

    // Número de página (derecha)
    doc.text(`Página ${pageNum} de ${totalPages}`, margenR, y, { align: 'right' });
}
