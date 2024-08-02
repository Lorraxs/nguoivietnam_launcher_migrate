import React, {useState} from 'react';
import {fetchNui} from '../utils/fetchNui';

function Main() {
  const [id, setId] = useState('');
  const [error, setError] = useState('');
  return (
    <div className="main rounded-2xl w-[550px] p-10 flex flex-col justify-center items-center gap-5 pointer-events-auto">
      <div className="text-center drop-shadow-md">
        <p>
          NẾU BẠN LÀ NGƯỜI CHƠI MỚI VUI LÒNG BỎ QUA THÔNG BÁO NÀY BẰNG CÁCH NHẤN
          VÀO NÚT <span className="text-red-500">BỎ QUA</span>
        </p>
        <br />
        <p>
          ĐỂ THỰC HIỆN VIỆC LIÊN KẾT DỮ LIỆU CỦA BẠN TỪ THẾ GIỚI CŨ. CHÚNG TÔI
          CẦN BẠN CUNG CẤP ID NHÂN VẬT CŨ
        </p>
        <br />
        <p>CÁM ƠN VÀ XIN LỖI VÌ SỰ PHIỀN PHỨC NÀY :{')'}</p>
      </div>
      <div>
        <input
          type="text"
          placeholder="Nhập ID nhân vật cũ"
          className="p-2 inline-block rounded-2xl text-black"
          value={id}
          onChange={e => setId(e.target.value)}
        />
      </div>
      {error && <div className="text-red-500 drop-shadow-md">{error}</div>}
      <div className="flex gap-5">
        <button
          className="btn btn-primary bg-white p-4 rounded-2xl border-4 border-transparent text-black hover:border-yellow-400"
          onClick={() => {
            if (!id) return setError('ID không được để trống');
            fetchNui('confirm', id);
          }}
        >
          Xác nhận
        </button>
        <button
          className="btn btn-secondary bg-red-500 p-4 rounded-2xl text-white border-4 border-transparent hover:border-yellow-400"
          onClick={() => {
            fetchNui('skip');
          }}
        >
          Bỏ qua
        </button>
      </div>
    </div>
  );
}

export default Main;
