<!DOCTYPE html>
<html lang="ar" dir="rtl" id="htmlRoot">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title id="pageTitle">منظومة المعلم الشاملة</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Cairo', sans-serif; background-color: #f1f5f9; }
        input[type=number]::-webkit-inner-spin-button, 
        input[type=number]::-webkit-outer-spin-button { -webkit-appearance: none; margin: 0; }
        input[type=number] { -moz-appearance: textfield; }
        @media print {
            .no-print { display: none !important; }
            .print-only { display: flex !important; }
            body { background-color: white; padding: 0; font-size: 10px; }
            .print-container { max-width: 100% !important; margin: 0 !important; padding: 0 !important; }
            input, select { border: none !important; background: transparent !important; padding: 0 !important; text-align: center; }
            table { width: 100% !important; border-collapse: collapse !important; }
            th, td { border: 1px solid #334155 !important; padding: 2px !important; white-space: nowrap !important; }
            .hidden-print-section { display: none !important; }
        }
    </style>
</head>
<body class="p-3 md:p-6 text-slate-800">

    <!-- Authentication Modal (Separate Sign Up & Login) -->
    <div id="loginModal" class="fixed inset-0 bg-slate-900/80 z-50 flex items-center justify-center p-4">
        <div class="bg-white rounded-2xl shadow-2xl max-w-md w-full p-6 space-y-5 relative">
            
            <div class="flex justify-end items-center">
                <div class="inline-flex rounded-xl bg-slate-100 p-1 shadow-sm border border-slate-200">
                    <button type="button" onclick="setLanguage('ar')" id="modalLangArBtn" class="px-3 py-1 text-xs font-bold rounded-lg bg-indigo-600 text-white transition cursor-pointer">العربية</button>
                    <button type="button" onclick="setLanguage('en')" id="modalLangEnBtn" class="px-3 py-1 text-xs font-bold rounded-lg text-slate-600 hover:text-slate-900 transition cursor-pointer">English</button>
                </div>
            </div>

            <div class="text-center">
                <span class="text-3xl">👨‍🏫</span>
                <h2 id="authModalHeaderTitle" class="text-xl font-extrabold text-slate-900 mt-2">تسجيل دخول المعلم</h2>
                <p id="authModalHeaderSubtitle" class="text-xs text-slate-500 mt-1">الوصول إلى بياناتك السحابية الخاصة والآمنة</p>
            </div>

            <!-- Tab Switcher for Login vs Register -->
            <div class="flex rounded-xl bg-slate-100 p-1 border border-slate-200">
                <button type="button" onclick="switchAuthMode('login')" id="tabLoginBtn" class="flex-1 py-2 text-xs font-bold rounded-lg bg-indigo-600 text-white transition cursor-pointer">تسجيل الدخول</button>
                <button type="button" onclick="switchAuthMode('register')" id="tabRegisterBtn" class="flex-1 py-2 text-xs font-bold rounded-lg text-slate-600 transition cursor-pointer">إنشاء حساب جديد</button>
            </div>
            
            <!-- Login Form -->
            <div id="loginFormContainer" class="space-y-3">
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">البريد الإلكتروني أو رقم الهاتف</label>
                    <input type="text" id="loginIdentifier" class="w-full border border-slate-300 rounded-xl p-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="teacher@example.com أو 0770...">
                </div>
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">كلمة المرور</label>
                    <input type="password" id="loginPassword" class="w-full border border-slate-300 rounded-xl p-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="••••••••">
                </div>
                <button type="button" onclick="handleLoginSubmit()" class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2.5 rounded-xl text-sm transition shadow-lg cursor-pointer">
                    تسجيل الدخول السحابي
                </button>
            </div>

            <!-- Register Form (Sign Up) -->
            <div id="registerFormContainer" class="space-y-3 hidden">
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">الاسم الكامل</label>
                    <input type="text" id="regName" class="w-full border border-slate-300 rounded-xl p-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500" value="الأستاذ بكر تركي">
                </div>
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">طريقة التسجيل المفضلة</label>
                    <select id="regType" onchange="toggleRegInputType()" class="w-full border border-slate-300 rounded-xl p-2.5 text-sm font-bold bg-white mb-2">
                        <option value="phone">تسجيل عبر رقم الهاتف</option>
                        <option value="email">تسجيل عبر البريد الإلكتروني</option>
                    </select>
                </div>
                <div id="regInputWrapper">
                    <label id="regInputLabel" class="block text-xs font-bold text-slate-700 mb-1">رقم الهاتف</label>
                    <input type="tel" id="regIdentifier" class="w-full border border-slate-300 rounded-xl p-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500" placeholder="07701234567">
                </div>
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">كلمة المرور الجديدة</label>
                    <input type="password" id="regPassword" class="w-full border border-slate-300 rounded-xl p-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500" placeholder="••••••••">
                </div>
                <button type="button" onclick="handleRegisterSubmit()" class="w-full bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-2.5 rounded-xl text-sm transition shadow-lg cursor-pointer">
                    إنشاء الحساب وحفظ البيانات سحابياً
                </button>
            </div>

        </div>
    </div>

    <!-- Student Absence Details Modal -->
    <div id="absenceModal" class="fixed inset-0 bg-slate-900/80 z-50 hidden flex items-center justify-center p-4">
        <div class="bg-white rounded-2xl shadow-2xl max-w-md w-full p-6 space-y-4 relative">
            <div class="flex justify-between items-center border-b pb-3">
                <h3 id="absenceModalTitle" class="text-base font-extrabold text-slate-900">سجل غياب الطالب</h3>
                <button type="button" onclick="closeAbsenceModal()" class="text-slate-400 hover:text-slate-700 font-bold text-lg cursor-pointer">✕</button>
            </div>
            <div id="absenceModalBody" class="space-y-2 max-h-60 overflow-y-auto text-xs">
                <!-- تفاصيل أيام الغياب مع اليوم تظهر هنا -->
            </div>
            <div class="flex justify-end pt-2">
                <button type="button" onclick="closeAbsenceModal()" class="bg-indigo-600 text-white px-4 py-2 rounded-xl text-xs font-bold cursor-pointer">إغلاق</button>
            </div>
        </div>
    </div>

    <div class="max-w-7xl mx-auto print-container">
        
        <!-- Language Switcher Bar -->
        <div class="flex justify-between items-center mb-3 no-print">
            <div class="text-xs font-bold text-indigo-700 bg-indigo-50 px-3 py-1.5 rounded-xl border border-indigo-200">
                👤 المستخدم الحالي: <span id="currentUserDisplay" class="text-slate-900 font-extrabold">زائر</span>
                <button type="button" onclick="logoutSystem()" class="mr-3 text-rose-600 hover:underline cursor-pointer">تسجيل خروج</button>
            </div>
            <div class="inline-flex rounded-xl bg-white p-1 shadow-sm border border-slate-200">
                <button type="button" onclick="setLanguage('ar')" id="langArBtn" class="px-3 py-1.5 text-xs font-bold rounded-lg bg-indigo-600 text-white transition cursor-pointer">العربية</button>
                <button type="button" onclick="setLanguage('en')" id="langEnBtn" class="px-3 py-1.5 text-xs font-bold rounded-lg text-slate-600 hover:text-slate-900 transition cursor-pointer">English</button>
            </div>
        </div>

        <!-- Official Print Header -->
        <div class="hidden print-only justify-between items-center border-b-2 border-slate-800 pb-4 mb-6 text-sm font-bold">
            <div>
                <p><span data-i18n="printSchool">المدرسة</span>: <span id="printSchoolName">....................</span></p>
                <p class="mt-1"><span data-i18n="printYear">العام الدراسي</span>: ٢٠٢٦ / ٢٠٢٧</p>
            </div>
            <div class="text-center">
                <h1 class="text-xl font-extrabold" data-i18n="printHeaderTitle">السجل السنوي الشامل لدرجات الطلاب</h1>
            </div>
            <div class="text-left">
                <p><span data-i18n="printTeacher">المعلم</span>: <span id="printTeacherName">....................</span></p>
                <p class="mt-1"><span data-i18n="printSubject">المادة</span>: <span id="printSubjectName">....................</span></p>
            </div>
        </div>

        <!-- Header -->
        <header class="bg-gradient-to-l from-indigo-900 to-indigo-700 text-white p-5 md:p-6 rounded-2xl shadow-lg mb-5 no-print">
            <div class="flex flex-col lg:flex-row justify-between items-start lg:items-center gap-4 mb-4">
                <div>
                    <h1 class="text-2xl md:text-3xl font-extrabold flex items-center gap-2">
                        <span>🎓</span> <span data-i18n="mainTitle">منظومة المعلم الشاملة</span>
                        <span class="text-amber-300 text-base md:text-lg font-bold mr-2">(إعداد الأستاذ: بكر تركي)</span>
                    </h1>
                    <p class="text-indigo-200 text-xs md:text-sm mt-1" data-i18n="mainSubtitle">إدارة متقدمة للطلاب، الحضور بالبصمة، وجداول الدرجات التلقائية مع مزامنة سحابية</p>
                </div>
                
                <!-- Action Buttons -->
                <div class="flex flex-wrap gap-2">
                    <button type="button" onclick="loadSampleData()" class="bg-emerald-600 hover:bg-emerald-700 text-white px-3 py-1.5 rounded-xl font-bold text-xs shadow transition flex items-center gap-1 cursor-pointer">
                        <span>👥</span> <span data-i18n="btnSample">استيراد طلاب تجريبيين</span>
                    </button>
                    <button type="button" onclick="exportToWord()" class="bg-sky-500 hover:bg-sky-600 text-white px-3 py-1.5 rounded-xl font-bold text-xs shadow transition flex items-center gap-1 cursor-pointer">
                        <span>📄</span> <span data-i18n="btnWord">تصدير Word</span>
                    </button>
                    <button type="button" onclick="exportToExcel()" class="bg-teal-600 hover:bg-teal-700 text-white px-3 py-1.5 rounded-xl font-bold text-xs shadow transition flex items-center gap-1 cursor-pointer">
                        <span>📊</span> <span data-i18n="btnExcel">تصدير Excel</span>
                    </button>
                    <button type="button" onclick="downloadBackup()" class="bg-amber-600 hover:bg-amber-700 text-white px-3 py-1.5 rounded-xl font-bold text-xs shadow transition flex items-center gap-1 cursor-pointer">
                        <span>💾</span> <span data-i18n="btnBackup">نسخة احتياطية</span>
                    </button>
                    <button type="button" onclick="window.print()" class="bg-indigo-500 hover:bg-indigo-600 text-white px-3 py-1.5 rounded-xl font-bold text-xs shadow transition flex items-center gap-1 cursor-pointer">
                        <span>🖨️</span> <span data-i18n="btnPrint">طباعة</span>
                    </button>
                    <button type="button" onclick="clearAllData()" class="bg-rose-600 hover:bg-rose-700 text-white px-3 py-1.5 rounded-xl font-bold text-xs shadow transition flex items-center gap-1 cursor-pointer">
                        <span>🗑️</span> <span data-i18n="btnClear">تصفير الكل</span>
                    </button>
                </div>
            </div>

            <!-- School, Teacher & Subject Inputs -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-3 pt-4 border-t border-indigo-500/55 text-slate-800">
                <div class="relative flex items-center">
                    <span class="absolute right-3 text-sm">🏫</span>
                    <input type="text" id="metaSchool" oninput="updatePrintMeta()" data-i18n-placeholder="placeholderSchool" placeholder="اسم المدرسة" 
                        class="w-full bg-white/95 rounded-xl pr-9 pl-3 py-2 text-xs font-bold focus:outline-none focus:ring-2 focus:ring-amber-400">
                </div>
                <div class="relative flex items-center">
                    <span class="absolute right-3 text-sm">👨‍🏫</span>
                    <input type="text" id="metaTeacher" oninput="updatePrintMeta()" data-i18n-placeholder="placeholderTeacher" placeholder="اسم المعلم" 
                        class="w-full bg-white/95 rounded-xl pr-9 pl-3 py-2 text-xs font-bold focus:outline-none focus:ring-2 focus:ring-amber-400">
                </div>
                <div class="relative flex items-center">
                    <span class="absolute right-3 text-sm">📚</span>
                    <input type="text" id="metaSubject" oninput="updatePrintMeta()" data-i18n-placeholder="placeholderSubject" placeholder="المادة الدراسية" 
                        class="w-full bg-white/95 rounded-xl pr-9 pl-3 py-2 text-xs font-bold focus:outline-none focus:ring-2 focus:ring-amber-400">
                </div>
            </div>
        </header>

        <!-- Navigation Tabs -->
        <nav class="flex flex-row flex-wrap gap-1.5 mb-6 bg-white p-2.5 rounded-2xl shadow-sm no-print justify-center items-center">
            <button type="button" onclick="switchTab('tasks')" id="tab-tasks" class="inline-flex items-center gap-1.5 py-2.5 px-3.5 rounded-xl font-bold text-xs transition bg-indigo-600 text-white shadow flex-1 justify-center min-w-[100px] cursor-pointer">
                <span>📝</span>
                <span class="bg-white/20 px-1.5 py-0.5 rounded text-[10px]">١</span>
                <span data-i18n="tabTasks">المهام والتحضير</span>
            </button>
            <button type="button" onclick="switchTab('students')" id="tab-students" class="inline-flex items-center gap-1.5 py-2.5 px-3.5 rounded-xl font-bold text-xs transition text-slate-600 hover:bg-slate-100 flex-1 justify-center min-w-[100px] cursor-pointer">
                <span>👨‍🎓</span>
                <span class="bg-slate-200 px-1.5 py-0.5 rounded text-[10px]">٢</span>
                <span data-i18n="tabStudents">إدارة الطلاب</span>
            </button>
            <button type="button" onclick="switchTab('schedule')" id="tab-schedule" class="inline-flex items-center gap-1.5 py-2.5 px-3.5 rounded-xl font-bold text-xs transition text-slate-600 hover:bg-slate-100 flex-1 justify-center min-w-[100px] cursor-pointer">
                <span>📅</span>
                <span class="bg-slate-200 px-1.5 py-0.5 rounded text-[10px]">٣</span>
                <span data-i18n="tabSchedule">جدول الحصص</span>
            </button>
            <button type="button" onclick="switchTab('attendance')" id="tab-attendance" class="inline-flex items-center gap-1.5 py-2.5 px-3.5 rounded-xl font-bold text-xs transition text-slate-600 hover:bg-slate-100 flex-1 justify-center min-w-[100px] cursor-pointer">
                <span>📋</span>
                <span class="bg-slate-200 px-1.5 py-0.5 rounded text-[10px]">٤</span>
                <span data-i18n="tabAttendance">الحضور والغياب</span>
            </button>
            <button type="button" onclick="switchTab('grades')" id="tab-grades" class="inline-flex items-center gap-1.5 py-2.5 px-3.5 rounded-xl font-bold text-xs transition text-slate-600 hover:bg-slate-100 flex-1 justify-center min-w-[100px] cursor-pointer">
                <span>📊</span>
                <span class="bg-slate-200 px-1.5 py-0.5 rounded text-[10px]">٥</span>
                <span data-i18n="tabGrades">جداول الدرجات</span>
            </button>
        </nav>

        <!-- Tasks Section -->
        <section id="section-tasks" class="space-y-5">
            <div class="bg-white p-5 rounded-2xl shadow-sm no-print">
                <h2 class="text-base font-bold text-slate-800 mb-3 flex items-center gap-2"><span>📌</span> <span data-i18n="taskAddTitle">إضافة مهمة أو تحضير درس</span></h2>
                <form id="taskForm" onsubmit="addTask(event)" class="grid grid-cols-1 md:grid-cols-4 gap-3">
                    <input type="text" id="taskTitleInput" data-i18n-placeholder="placeholderTaskTitle" placeholder="عنوان المهمة / تحضير الدرس" required class="border border-slate-300 rounded-xl p-2.5 text-sm md:col-span-2">
                    <select id="taskGradeSelect" class="border border-slate-300 rounded-xl p-2.5 text-sm">
                        <option value="all" data-i18n="optAllGrades">جميع الصفوف</option>
                        <option value="الصف الأول">الصف الأول</option>
                        <option value="الصف الثاني">الصف الثاني</option>
                        <option value="الصف الثالث">الصف الثالث</option>
                        <option value="الصف الرابع">الصف الرابع</option>
                        <option value="الصف الخامس">الصف الخامس</option>
                        <option value="الصف السادس">الصف السادس</option>
                    </select>
                    <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2.5 px-4 rounded-xl text-sm cursor-pointer" data-i18n="btnAddAction">
                        + إضافة مهمة
                    </button>
                </form>
            </div>

            <div class="bg-white p-5 rounded-2xl shadow-sm">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-base font-bold text-slate-800 flex items-center gap-2"><span>📋</span> <span data-i18n="taskListTitle">قائمة المهام</span></h2>
                    <span id="taskCounter" class="bg-indigo-100 text-indigo-800 px-3 py-1 rounded-xl text-xs font-bold">٠ / ٠ منجز</span>
                </div>
                <div id="taskListContainer" class="space-y-2.5">
                    <p class="text-slate-500 text-sm" data-i18n="noTasks">لا توجد مهام مضافة حتى الآن.</p>
                </div>
            </div>
        </section>

        <!-- Students Management Section -->
        <section id="section-students" class="hidden space-y-6">
            <div class="bg-white p-5 rounded-2xl shadow-sm no-print">
                <h2 class="text-base font-bold text-slate-800 mb-3 flex items-center gap-2"><span>👨‍🎓</span> <span data-i18n="addStudentTitle">إضافة طالب جديد مع تحديد الصف والشعبة</span></h2>
                <form id="studentForm" onsubmit="addStudent(event)" class="grid grid-cols-1 md:grid-cols-5 gap-3">
                    <input type="text" id="newName" data-i18n-placeholder="placeholderStudentName" placeholder="اسم الطالب الثلاثي" required class="border border-slate-300 rounded-xl p-2.5 text-sm">
                    <input type="text" id="newPhone" data-i18n-placeholder="placeholderPhone" placeholder="الهاتف (مثال: 0770...)" class="border border-slate-300 rounded-xl p-2.5 text-sm">
                    <select id="newGrade" class="border border-slate-300 rounded-xl p-2.5 text-sm"